/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.slot; 

public class SlotTime {
    private int slotID;
    private String slotTime;

    public SlotTime() {
    }

    public SlotTime(int slotID, String slotTime) {
        this.slotID = slotID;
        this.slotTime = slotTime;
    }

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    public String getSlotTime() {
        return slotTime;
    }

    public void setSlotTime(String slotTime) {
        this.slotTime = slotTime;
    }
    
}
