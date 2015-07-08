angular.module 'flipUL', [

]

.directive 'flipUl', ->
  restrict: 'A'
  scope:
    items: '=flipUl'
    choices: '='
    attr: '@'
    editMode: '=?'
    onAdd: '&'
    onRemove: '&'
  templateUrl: 'flipUL/flipUL.html'
  link: (scope, element, attrs) ->
    s = scope
    key = attrs.key || s.attr
    s.editMode = s.editMode || false
    
    s.dynChoices = ->
      ids = (x[key] for x in s.items)
      s.choices.filter (x) -> !(x[key] in ids)
      .sort()

    s.dynFilter = (x) ->
      resp = {}
      resp[s.attr] = x
      
    s.add = (item) ->
      if item
        s.items.push item
        s.newItem = null
        s.onAdd({item:item})

    s.remove = (item) ->
      ids = (x[key] for x in s.items)
      s.items.splice ids.indexOf(item[key]), 1
      s.onRemove({item:item})



.run ($templateCache) ->
  $templateCache.put 'flipUL/flipUL.html', """
    <li ng-show="items.length==0">None</li>
    <li ng-repeat="item in items"> {{item[attr]}}
        <span ng-if="editMode" ng-click="remove(item)" style="cursor:pointer">
          <i class="fa fa-remove"></i>
        </span>
      </span>
    </li>
    <li ng-show="editMode">
      <span style="width:200px" class="input-group">
        <input ng-model="newItem"
               typeahead="x as x[attr] for x in dynChoices() | filter:dynFilter($viewValue)"
               typeahead-editable="false"
               class="form-control"
        />
        <span class="input-group-btn">
          <button ng-click="add(newItem)" class="btn btn-default">
            <i style="height:20px;padding-top:3px" class="fa fa-plus fa-fw"></i>
          </button>
        </span>
      </span>
    </li>
  """
