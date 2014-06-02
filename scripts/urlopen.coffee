module.exports = (robot) ->
  robot.hear /(https?:\/\/\S*)/i, (msg) ->
    url = msg.match[1]

    # msg.send "url: " + url

    robot.http(url)
    .get() (err, res, body) ->
      if !err
        result = body.match(/<title>(.+)<\/title>/i)
        if result?
          msg.send "【タイトル】" + result[1]

