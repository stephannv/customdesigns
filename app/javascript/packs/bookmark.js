console.log('bookmark')

const bookmarkLinks = document.querySelectorAll('.bookmark-link')

bookmarkLinks.forEach((bookmarkLink) => {
  const href = bookmarkLink.href

  bookmarkLink.addEventListener('ajax:beforeSend', (e) => {
    if (e.target.href === 'javascript: void(0);') {
      e.preventDefault()
      e.stopImmediatePropagation()
      return false
    }

    bookmarkLink.setAttribute('href', 'javascript: void(0);')
    const icon = bookmarkLink.querySelector('span > .bookmark-icon')
    icon.classList.remove('fa-bookmark')
    icon.classList.remove('far')
    icon.classList.add('fas')
    icon.classList.add('fa-spinner')
    icon.classList.add('fa-spin')
  })

  bookmarkLink.addEventListener('ajax:success', () => {
    const icon = bookmarkLink.querySelector('span > .bookmark-icon')
    const bookmarkCountText = bookmarkLink.querySelector('.bookmark-count')

    if (bookmarkLink.dataset.method === "post") {
      bookmarkLink.dataset.method = 'delete'
      icon.classList.remove('far')
      icon.classList.add('fas')

      let bookmarkCount = parseInt(bookmarkCountText.innerHTML)
      bookmarkCountText.innerHTML = bookmarkCount + 1
    } else {
      bookmarkLink.dataset.method = 'post'
      icon.classList.remove('fas')
      icon.classList.add('far')
      let bookmarkCount = parseInt(bookmarkCountText.innerHTML)
      bookmarkCountText.innerHTML = bookmarkCount - 1
    }
  })

  bookmarkLink.addEventListener('ajax:complete', () => {
    bookmarkLink.setAttribute('href', href)
    const icon = bookmarkLink.querySelector('span > .bookmark-icon')
    icon.classList.remove('fa-spin')
    icon.classList.remove('fa-spinner')
    icon.classList.add('fa-bookmark')
  })
})
