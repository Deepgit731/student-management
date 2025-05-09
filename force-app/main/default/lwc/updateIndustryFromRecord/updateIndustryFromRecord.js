import { LightningElement, api, track } from 'lwc';
import updateAccountIndustry from '@salesforce/apex/accountController.updateAccountIndustry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpdateIndustryFromRecord extends LightningElement {
    @api recordId;  
    @track newIndustry = '';  
    handleIndustryChange(event) {
        this.newIndustry = event.target.value;
    }
    handleUpdateClick() {
        if (!this.newIndustry) {
            this.showToast('Error', 'Please provide a valid Industry.', 'error');
            return;
        }
        updateAccountIndustry({ accountId: this.recordId, newIndustry: this.newIndustry })
            .then(() => {
                this.showToast('Success', 'Industry updated successfully!', 'success');
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant,
            })
        );
    }
}
