msgs = [
  '(((o(' + '*ﾟ▽ﾟ*' + ')o)))',
  '( ' + '*ﾟ▽ﾟ*' + '  っ)З',
]

module.exports = (robot) ->
  robot.hear /[ち][ょ][ま][ど]/, (msg) ->
    i = parseInt(Math.random() * 2, 10)
    msg.send msgs[i]
