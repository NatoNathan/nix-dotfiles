function Bar(monitor = 0) {
  const myLabel = Widget.Label({
      label: 'some example content',
  })

  Utils.interval(1000, () => {
      myLabel.label = Utils.exec('date')
  })

  return Widget.Window({
      monitor,
      name: `bar${monitor}`,
      anchor: ['top', 'left', 'right'],
      child: myLabel,
  })
}

App.config({ windows: [bar(0), bar(1)] });