(function() {
  var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module('flipUL', []).directive('flipUl', function() {
    return {
      restrict: 'A',
      scope: {
        items: '=flipUl',
        choices: '=',
        attr: '@',
        editMode: '=?',
        onAdd: '&',
        onRemove: '&'
      },
      templateUrl: 'flipUL/flipUL.html',
      link: function(scope, element, attrs) {
        var key, s;
        s = scope;
        key = attrs.key || s.attr;
        s.editMode = s.editMode || false;
        s.dynChoices = function() {
          var ids, x;
          ids = (function() {
            var i, len, ref, results;
            ref = s.items;
            results = [];
            for (i = 0, len = ref.length; i < len; i++) {
              x = ref[i];
              results.push(x[key]);
            }
            return results;
          })();
          return s.choices.filter(function(x) {
            var ref;
            return !(ref = x[key], indexOf.call(ids, ref) >= 0);
          }).sort();
        };
        s.dynFilter = function(x) {
          var resp;
          resp = {};
          return resp[s.attr] = x;
        };
        s.add = function(item) {
          if (item) {
            s.items.push(item);
            s.newItem = null;
            return s.onAdd({
              item: item
            });
          }
        };
        return s.remove = function(item) {
          var ids, x;
          ids = (function() {
            var i, len, ref, results;
            ref = s.items;
            results = [];
            for (i = 0, len = ref.length; i < len; i++) {
              x = ref[i];
              results.push(x[key]);
            }
            return results;
          })();
          s.items.splice(ids.indexOf(item[key]), 1);
          return s.onRemove({
            item: item
          });
        };
      }
    };
  }).run(["$templateCache", function($templateCache) {
    return $templateCache.put('flipUL/flipUL.html', "<li ng-show=\"items.length==0\">None</li>\n<li ng-repeat=\"item in items\"> {{item[attr]}}\n    <span ng-if=\"editMode\" ng-click=\"remove(item)\" style=\"cursor:pointer\">\n      <i class=\"fa fa-remove\"></i>\n    </span>\n  </span>\n</li>\n<li ng-show=\"editMode\">\n  <span style=\"width:200px\" class=\"input-group\">\n    <input ng-model=\"newItem\"\n           typeahead=\"x as x[attr] for x in dynChoices() | filter:dynFilter($viewValue)\"\n           typeahead-editable=\"false\"\n           class=\"form-control\"\n    />\n    <span class=\"input-group-btn\">\n      <button ng-click=\"add(newItem)\" class=\"btn btn-default\">\n        <i style=\"height:20px;padding-top:3px\" class=\"fa fa-plus fa-fw\"></i>\n      </button>\n    </span>\n  </span>\n</li>");
  }]);

}).call(this);
