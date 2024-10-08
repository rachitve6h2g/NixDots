const date = Variable('', {
  poll: [ 1000, 'date' ],
})

const myBar = Widget.Window({
  name: 'bar',
  anchor: [ 'top', 'left', 'right' ],
  child: Widget.Label({label: date.bind()}),
})

App.config({
  windows: [
    myBar
  ]
})
