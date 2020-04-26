const creatorIdField = document.getElementById('creator_creator_id')
const creatorIdValue = creatorIdField.value

const cleave = new Cleave(creatorIdField, {
  prefix: 'MA',
  delimiter: '-',
  blocks: [2, 4, 4, 4],
  numericOnly: true
})

cleave.onInput(creatorIdValue)
