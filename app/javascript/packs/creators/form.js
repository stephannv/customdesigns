// CREATOR ID
const creatorIdField = document.getElementById('creator_creator_id')
const creatorIdValue = creatorIdField.value

const creatorIdCleave = new Cleave(creatorIdField, {
  prefix: 'MA',
  delimiter: '-',
  blocks: [2, 4, 4, 4],
  numericOnly: true
})

creatorIdCleave.onInput(creatorIdValue)

// FRIEND CODE
const friendCodeField = document.getElementById('creator_friend_code')
const friendCodeValue = friendCodeField.value

const friendCodeCleave = new Cleave(friendCodeField, {
  prefix: 'SW',
  delimiter: '-',
  blocks: [2, 4, 4, 4],
  numericOnly: true
})

friendCodeCleave.onInput(friendCodeValue)
