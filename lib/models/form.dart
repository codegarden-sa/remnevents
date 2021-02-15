class FeedbackForm {
  String _startDate;
  String _endDate;
  String _time;
  String _dept;
  String _event;
  String _venue;

  FeedbackForm(this._startDate, this._endDate, this._time, this._dept,
      this._event, this._venue);

  // Method to make GET parameters.
  String toParams() =>
      "?startDate=$_startDate&endDate=$_endDate&time=$_time&dept=$_dept&department=$_dept&event=$_event&venue=$_venue";
}
