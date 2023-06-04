package Entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
public class Student {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "student_id")
    private int studentId;
    @Basic
    @Column(name = "student_name")
    private String studentName;
    @Basic
    @Column(name = "dob")
    private Date dob;
    @Basic
    @Column(name = "gender")
    private Boolean gender;
    @Basic
    @Column(name = "address")
    private String address;
    @Basic
    @Column(name = "parent_id")
    private Integer parentId;

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Student student = (Student) o;

        if (studentId != student.studentId) return false;
        if (studentName != null ? !studentName.equals(student.studentName) : student.studentName != null) return false;
        if (dob != null ? !dob.equals(student.dob) : student.dob != null) return false;
        if (gender != null ? !gender.equals(student.gender) : student.gender != null) return false;
        if (address != null ? !address.equals(student.address) : student.address != null) return false;
        if (parentId != null ? !parentId.equals(student.parentId) : student.parentId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = studentId;
        result = 31 * result + (studentName != null ? studentName.hashCode() : 0);
        result = 31 * result + (dob != null ? dob.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (parentId != null ? parentId.hashCode() : 0);
        return result;
    }
}
