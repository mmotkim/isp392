package Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "class", schema = "dbo", catalog = "ISP392_IS1701")
public class Class {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "class_id")
    private int classId;
    @Basic
    @Column(name = "class_name")
    private String className;
    @Basic
    @Column(name = "level")
    private Integer level;
    @Basic
    @Column(name = "student_quantity")
    private Integer studentQuantity;

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getStudentQuantity() {
        return studentQuantity;
    }

    public void setStudentQuantity(Integer studentQuantity) {
        this.studentQuantity = studentQuantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Class clazz = (Class) o;

        if (classId != clazz.classId) return false;
        if (className != null ? !className.equals(clazz.className) : clazz.className != null) return false;
        if (level != null ? !level.equals(clazz.level) : clazz.level != null) return false;
        if (studentQuantity != null ? !studentQuantity.equals(clazz.studentQuantity) : clazz.studentQuantity != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = classId;
        result = 31 * result + (className != null ? className.hashCode() : 0);
        result = 31 * result + (level != null ? level.hashCode() : 0);
        result = 31 * result + (studentQuantity != null ? studentQuantity.hashCode() : 0);
        return result;
    }
}
