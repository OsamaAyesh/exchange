
class AttendanceModel {
  int? id;
  String? attendanceTime;
  String? attendanceDate;
  String? leaveTime;
  String? leaveDate;
  int? status;

  AttendanceModel(
      {this.id,
        this.attendanceTime,
        this.attendanceDate,
        this.leaveTime,
        this.leaveDate,
        this.status});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceTime = json['attendance_time'];
    attendanceDate = json['attendance_date'];
    leaveTime = json['leave_time'];
    leaveDate = json['leave_date'];
    status = json['status'];
  }


}

class DataAttendanceExtra {
  int? attendanceDays;
  int? absenceDays;

  DataAttendanceExtra({this.attendanceDays, this.absenceDays});

  DataAttendanceExtra.fromJson(Map<String, dynamic> json) {
    attendanceDays = json['attendanceDays'];
    absenceDays = json['absenceDays'];
  }

}