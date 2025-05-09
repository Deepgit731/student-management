import { LightningElement, api, track } from 'lwc';

export default class CaseDetail extends LightningElement {
    @api caseId;  // The case ID passed from parent (caseDashboard)
    @track isVisible = false;  // Track visibility of the modal

    // Toggles the visibility of the case detail modal
    @api
    toggleVisibility() {
        this.isVisible = !this.isVisible;
    }

    // Handle closing the modal
    handleClose() {
        this.isVisible = false;
    }

    // Handle showing related contacts
    handleRelatedContacts() {
        // Logic to show related contacts (optional feature)
    }

    // Handle showing related notes
    handleRelatedNotes() {
        // Logic to show related notes (optional feature)
    }
}
