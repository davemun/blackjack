class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand(@model.get('playerHand'))

  initialize: ->
    @model.get('dealerHand').on 'playerWin', => @win()
    @model.get('dealerHand').on 'playerLose', => @lose()
    @model.get('dealerHand').on 'tie', => @tie()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  win: ->
    console.log("won")
    node = $('<span></span>').text("PLAYER WINS").addClass("outcome")
    @$el.append(node)
  lose: ->
    console.log("lost")
    node = $('<span></span>').text("PLAYER LOSES").addClass("outcome")
    @$el.append(node)
  tie: ->
    console.log("tie")
    node = $('<span></span>').text("TIE GAME").addClass("outcome")
    @$el.append(node)
