package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Transaction {

    private int id;
    private int accountId;
    private Timestamp createdDate;
    private double value;
    private String note;

    public Transaction() {
    }

    public Transaction(int id, int accountId, Timestamp createdDate, double value, String note) {
        this.id = id;
        this.accountId = accountId;
        this.createdDate = createdDate;
        this.value = value;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Transaction{" + "id=" + id + ", accountId=" + accountId + ", createdDate=" + createdDate + ", value=" + value + ", note=" + note + '}';
    }
}
