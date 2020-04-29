const heartLinks = document.querySelectorAll('.heart-link')

heartLinks.forEach((heartLink) => {
  const href = heartLink.href

  heartLink.addEventListener('ajax:beforeSend', (e) => {
    if (e.target.href === 'javascript: void(0);') {
      e.preventDefault()
      e.stopImmediatePropagation()
      return false
    }

    heartLink.setAttribute('href', 'javascript: void(0);')
    const icon = heartLink.querySelector('span > .heart-icon')
    icon.classList.remove('fa-heart')
    icon.classList.remove('far')
    icon.classList.add('fas')
    icon.classList.add('fa-spinner')
    icon.classList.add('fa-spin')
  })

  heartLink.addEventListener('ajax:success', () => {
    const icon = heartLink.querySelector('span > .heart-icon')
    const heartCountText = heartLink.querySelector('.heart-count')

    if (heartLink.dataset.method === "post") {
      heartLink.dataset.method = 'delete'
      icon.classList.remove('far')
      icon.classList.add('fas')

      let heartCount = parseInt(heartCountText.innerHTML)
      heartCountText.innerHTML = heartCount + 1
    } else {
      heartLink.dataset.method = 'post'
      icon.classList.remove('fas')
      icon.classList.add('far')
      let heartCount = parseInt(heartCountText.innerHTML)
      heartCountText.innerHTML = heartCount - 1
    }
  })

  heartLink.addEventListener('ajax:complete', () => {
    heartLink.setAttribute('href', href)
    const icon = heartLink.querySelector('span > .heart-icon')
    icon.classList.remove('fa-spin')
    icon.classList.remove('fa-spinner')
    icon.classList.add('fa-heart')
  })
})
