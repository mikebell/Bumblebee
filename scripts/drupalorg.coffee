# Description:
#   Display issue/page information from drupal.org
#
# Dependencies:
#   "cheerio": ""
#
# Configuration:
#   NONE
#
# Commands:
#   hubot drupal.org url - Show details about a drupal.org page or issue
#   hubot dm module name - Find module info from name
#
# Notes:
#
# Author:
#   mikebell

module.exports = (robot) ->
  robot.hear /https?:\/\/(www\.)?drupal.org\/node\/(\w+)/i, (msg) ->
    msg
      .http(msg.match[0])
      .get() (err, res, body) ->
        $ = require("cheerio").load(body)
        title = $('#page-subtitle').text()
        projectname = $('.field-name-field-project .field-item').text()
        issuestatus = $('.field-name-field-issue-status .field-item').text()
        # issuebody = $('.field-name-body .field-item p').first().text()

        console.log(err)

        msg.send '[' + projectname + '] - ' + title + ' [' + issuestatus + ']'

  robot.hear /dm (\w*)/i, (msg) ->
    msg
      .http('https://www.drupal.org/project/' + msg.match[1])
      .get() (err, res, body) ->
        $ = require("cheerio").load(body)
        title = $('#page-subtitle').text()
        url = 'https://www.drupal.org/project/' + msg.match[1]
        description = $('.field-name-body .field-item p').first().text()

        msg.send '[' + title + '] - ' + url
        msg.send description
