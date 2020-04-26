addFileInputListener = (selector) => {
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

const designIdField = document.getElementById('custom_design_design_id')
const designIdValue = designIdField.value

const cleave = new Cleave(designIdField, {
  prefix: 'MO',
  delimiter: '-',
  blocks: [2, 4, 4, 4],
  uppercase: true
})

cleave.onInput(designIdValue)
