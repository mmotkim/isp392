package Entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
@Table(name = "attendanceOfStudent", schema = "dbo", catalog = "ISP392_IS1701")
public class Attendance {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id", nullable = false)
    private int id;
    @Basic
    @Column(name = "student_id", nullable = false)
    private int studentId;
    @Basic
    @Column(name = "status", nullable = true)
    private Boolean status;
    @Basic
    @Column(name = "reason", nullable = true, length = 100)
    private String reason;
    @Basic
    @Column(name = "date", nullable = false)
    private Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Attendance that = (Attendance) o;

        if (id != that.id) return false;
        if (studentId != that.studentId) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + studentId;
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        return result;
    }
}
