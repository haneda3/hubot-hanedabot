getTitle = (robot, msg, url, redirectRemains) ->
  #console.log("getTitle " + url + " " + redirectRemains)
  return if redirectRemains < 0

  robot.http(url)
  .get() (err, res, body) ->
    redirectStautus = [301, 302]

    if res.statusCode in redirectStautus
      # なぜかres.getHeaderは使えない
      location = res.headers["location"]
      getTitle(robot, msg, location, redirectRemains - 1) if location?
      return

    if !err
      result = body.match(/<title>(.+)<\/title>/i)
      if result?
        msg.send "【タイトル】" + result[1]

module.exports = (robot) ->
  robot.hear /(https?:\/\/\S*)/i, (msg) ->
    url = msg.match[1]

    getTitle(robot, msg, url, 5)

