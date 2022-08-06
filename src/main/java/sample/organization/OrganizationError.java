/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.organization;

/**
 *
 * @author light
 */
public class OrganizationError {

    private String orgIDError;
    private String orgNameError;
    private String descriptionError;
    private String emailError;
    private String imgUrlError;
    private String statusError;

    public OrganizationError() {
        this.orgIDError = "";
        this.orgNameError = "";
        this.descriptionError = "";
        this.emailError = "";
        this.imgUrlError = "";
        this.statusError = "";
    }

    public OrganizationError(String orgIDError, String orgNameError, String descriptionError, String imgUrlError, String statusError, String emailError) {
        this.orgIDError = orgIDError;
        this.orgNameError = orgNameError;
        this.descriptionError = descriptionError;
        this.imgUrlError = imgUrlError;
        this.statusError = statusError;
        this.emailError = emailError;
    }

    public String getStatusError() {
        return statusError;
    }

    public void setStatusError(String statusError) {
        this.statusError = statusError;
    }
    
    public String getOrgIDError() {
        return orgIDError;
    }

    public void setOrgIDError(String orgIDError) {
        this.orgIDError = orgIDError;
    }

    public String getOrgNameError() {
        return orgNameError;
    }

    public void setOrgNameError(String orgNameError) {
        this.orgNameError = orgNameError;
    }

    public String getDescriptionError() {
        return descriptionError;
    }

    public void setDescriptionError(String descriptionError) {
        this.descriptionError = descriptionError;
    }

    public String getImgUrlError() {
        return imgUrlError;
    }

    public void setImgUrlError(String imgUrlError) {
        this.imgUrlError = imgUrlError;
    }

}
