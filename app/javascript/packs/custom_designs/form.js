import Tagify from '@yaireo/tagify'

// IMAGES INPUT
const addFileInputListener = (selector) => {
  const fileInput = document.querySelector(`${selector} input[type=file]`)

  fileInput.onchange = () => {
    if (fileInput.files && fileInput.files.length > 0) {
      const fileName = document.querySelector(`${selector} .file-name`)
      fileName.textContent = fileInput.files[0].name
    }
  }
}

addFileInputListener('#main-picture-div')
addFileInputListener('#example-picture-div')

// DESIGN ID INPUT
const designIdField = document.getElementById('custom_design_design_id')
const designIdValue = designIdField.value

const cleave = new Cleave(designIdField, {
  prefix: 'MO',
  delimiter: '-',
  blocks: [2, 4, 4, 4],
  uppercase: true
})

cleave.onInput(designIdValue)

// CATEGORIES SELECT
const categoriesSelect = document.getElementById('custom_design_category_ids')
categoriesSelect.size = categoriesSelect.length


// TAGS
const debounce = (cb, interval, immediate) => {
  var timeout

  return function() {
    var context = this, args = arguments
    var later = function() {
      timeout = null
      if (!immediate) cb.apply(context, args)
    }

    var callNow = immediate && !timeout

    clearTimeout(timeout)
    timeout = setTimeout(later, interval)

    if (callNow) cb.apply(context, args)
  }
}

const unaccent = (string) => {
  return string.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
}

const input = document.getElementById('custom_design_tags')
const tagify = new Tagify(input, {
  whitelist: [],
  pattern: /^[a-zA-ZÀ-ú0-9_. ]*$/,
  skipInvalid: true,
  maxTags: 5,
  dropdown: { fuzzySearch: true }
})

let controller
const onTagInput = (e) => {
  var value = e.detail.value
  tagify.settings.whitelist.length = 0 // reset the whitelist

  controller && controller.abort()
  controller = new AbortController()

  tagify.loading(true).dropdown.hide.call(tagify)

  fetch('/tags?search=' + value, {signal:controller.signal})
    .then(RES => RES.json())
    .then(function(suggestionList){
      const unaccentSuggestionList = suggestionList.map((e) => unaccent(e))
      tagify.settings.whitelist.splice(0, suggestionList.length, ...unaccentSuggestionList)
      tagify.loading(false).dropdown.show.call(tagify, unaccent(value)) // render the suggestions dropdown
    })
}

tagify.on('input', debounce(onTagInput, 500))
