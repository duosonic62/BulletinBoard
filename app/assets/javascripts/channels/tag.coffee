App.tag = App.cable.subscriptions.create "TagChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if !data['error_message']
      # エラーメッセージがない場合のみ登録
      $('#tag_checkboxies').append data['tag_checkbox']
    else
      # エラーメッセージがあった場合はポップアップで表示
      alert(data['error_message'])

  create: (tag_name)->
    @perform 'create', tag_name: tag_name

  rejected: ->
    @perform 'unsubscribed'


  $(document).on 'click', '#tag_create', (event) ->
    tag_name = $('#tag_name').val()
    # から文字を送ろうとしたらリジェクトする
    if !tag_name
      App.tag.rejected
    else
      App.tag.create $('#tag_name').val()
    