app = angular.module("aaDatepickerLib", [])

app.directive "aaDatepicker", [->
  restrict: "E"
  require: "ngModel"
  scope:
    label: "@"
    hoverText: "@"
    placeholder: "@"
    iconClass: "@"
    ngModel: "="

  replace: true
  link: (scope, element, attrs, ngModel) ->
    
    # INITIALIZE VARIABLES
    # ================================
    scope.calendarShown = false
    scope.dayCodes = ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
    scope.weeks = []
    setDate = ->
      scope.chosenDateTime = (if scope.ngModel then Date.parse(scope.ngModel) else null)
      
      # scope.chosenDateTimeStr = scope.chosenDateTime ? scope.chosenDateTime.toString('M/d/yyyy h:mm tt') : attrs.placeholder;
      scope.chosenDateStr = (if scope.chosenDateTime then scope.chosenDateTime.toString("M/d/yyyy") else attrs.placeholder)

    
    # scope.chosenTimeStr = scope.chosenDateTime ? scope.chosenDateTime.toString('h:mm tt') : null;
    
    # DATA BINDING / WATCHING
    scope.$watch "ngModel", setDate
    
    # VIEW ACTIONS
    # ================================
    scope.toggleCalendar = ->
      scope.calendarShown = not scope.calendarShown

  
  # <div class='aa-input-wrapper'><label>Time</label><input type='text' ng-model='chosenTimeStr' placeholder='12:00pm' /></div>
  template: """
            <div class='aa-datepicker'><a href='' ng-click='toggleCalendar()' class='aa-datepicker-button' title='{{hoverText}}'><i class='{{iconClass}}' ng-show='iconClass'></i>{{chosenDateStr}}</a>
              <div class='aa-calendar-wrapper' ng-class='{open: calendarShown}'>
                <div class='aa-calendar-header'>{{chosenDateStr}}<a href='' class='close' ng-click='toggleCalendar()'>X</a></div>
                <div class='aa-input-wrapper'><label>Date</label><input class='aa-date-text-input' type='text' ng-model='chosenDateStr' placeholder='1/1/2013' /></div>
                <table class='aa-calendar'>
                  <thead>
                    <tr>
                      <th ng-repeat='day in dayCodes'>{{day}}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr ng-repeat='week in weeks'>
                      <td ng-repeat='day in week.days'>{{day}}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            """
]