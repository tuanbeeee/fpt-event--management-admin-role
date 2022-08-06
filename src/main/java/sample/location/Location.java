/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.location;

/**
 *
 * @author light
 */
public class Location {

    private int locationID;
    private String locationName;
    private boolean status;

    public Location(int locationID, String locationName, boolean status) {
        this.locationID = locationID;
        this.locationName = locationName;
        this.status = status;
    }

    public Location(String locationName, boolean status) {
        this.status = status;
        this.locationName = locationName;
    }
    

    public Location() {
        this.locationID = 0;
        this.locationName = "";
        this.status = false;
    }

    public int getLocationID() {
        return locationID;
    }

    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
