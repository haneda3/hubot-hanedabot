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

getOGP = (robot, msg, url) ->
  robot.http(url)
  .get() (err, res, body) ->
    return if err

    result = body.match(/<meta property=\"og:description\" content=\"([\s\S]*?)\"/i)
    if result?
      msg.send "og:description " + result[1]
    result = body.match(/<meta property=\"og:image\" content=\"(.+)\"/i)
    if result?
      msg.send "og:image " + result[1]

module.exports = (robot) ->
  robot.hear /(https?:\/\/\S*)/i, (msg) ->
    url = msg.match[1]

    getTitle(robot, msg, url, 5)
    getOGP(robot, msg, url)

