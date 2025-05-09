import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import deleteCaseRecord from '@salesforce/apex/CaseController.deleteCase';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseDashboard extends NavigationMixin(LightningElement) {
    @track selectedStatus = '';
    @track selectedPriority = '';
    @track selectedOrigin = '';
    @track isFormOpen = false;
    @track selectedCaseId;

    handleFilterChange(event) {
        const { status, priority, origin } = event.detail; 
        this.selectedStatus = status;
        this.selectedPriority = priority;
        this.selectedOrigin = origin;
    }

    handleView(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.caseId,
                objectApiName: 'Case',
                actionName: 'view'
            }
        });
    }

    handleEdit(event) {
        this.selectedCaseId = event.detail.caseId;
        this.isFormOpen = true;
    }

    handleModalClose() {
        this.isFormOpen = false;
        this.selectedCaseId = null;
    }

    refreshCaseList() {
        const caseListComponent = this.template.querySelector('c-case-list');
        if (caseListComponent && typeof caseListComponent.refreshCases === 'function') {
            caseListComponent.refreshCases();
        }
        this.handleModalClose();
    }

    handleDelete(event) {
        const caseId = event.detail.caseId;

        deleteCaseRecord({ caseId })
            .then(() => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Case deleted',
                    variant: 'success'
                }));
                this.refreshCaseList();
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error deleting case',
                    message: error.body?.message || 'Unknown error',
                    variant: 'error'
                }));
            });
    }
    handleNewCase() {
        this.selectedCaseId = null; 
        this.isFormOpen = true;
    }
}