package Entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
public class ClassActivity {
    @Basic
    @Column(name = "class_id", nullable = false)
    private int classId;
    @Basic
    @Column(name = "activity_id", nullable = false)
    private int activityId;
    @Basic
    @Column(name = "date", nullable = true)
    private Date date;
    @Basic
    @Column(name = "slot", nullable = true)
    private int slot;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "slotId", nullable = false)
    private int slotId;

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }
}
