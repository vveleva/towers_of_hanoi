(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $el) {
    this.$startTower = 'undefined';
    this.game = new Game();
    this.$el = $el;
  };

  View.prototype.clickTower = function () {
    this.render();
    this.$el.on('click', '.sq', function(event) {
      if (this.$startTower === 'undefined') {
        this.$startTower = $(event.currentTarget);
      } else {
        var $endTower = $(event.currentTarget);
        var from = parseInt(this.$startTower.attr('id'));
        var to = parseInt($endTower.attr('id'));
        this.game.move(from, to);
        this.$startTower = 'undefined';
        this.render();
      }
      if (this.game.isWon()) {
        this.$el.after($('<div class="game-over">you won!</div>'));
      }
    }.bind(this));
  };

  View.prototype.render = function () {
    var towers = this.game.towers;
    towers.forEach(function(tower, idx) {
      for (var i = 0; i < 3; i++) {
        var disk = tower[i];
        $("#disk-" + disk).remove();
        $('#' + idx).append($('<div class="disk" id="disk-' + disk + '"></div>'));
       }
    });
  };

  View.prototype.setupTowers = function () {
    for(var i = 0; i < 3; i++) {
      var $div = $("<div id=" + i + " class='sq'>");
      this.$el.append($div);
    }
    this.clickTower();
  };
})();
