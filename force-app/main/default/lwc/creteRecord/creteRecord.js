import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreteRecord extends LightningElement {
    @api recordId;
    name = '';
    email = '';
    phone = '';

    handleChange(event) {
        const field = event.target.label;
        if (field === 'Name') this.name = event.target.value;
        else if (field === 'Email') this.email = event.target.value;
        else if (field === 'Phone') this.phone = event.target.value;
    }

    handleCreate() {
        if (!this.name || !this.email) {
            this.showToast('Error', 'Name and Email are required.', 'error');
            return;
        }
        createRecord({
            apiName: 'Contact',
            fields: {
                LastName: this.name,
                Email: this.email,
                Phone: this.phone,
                AccountId: this.recordId
            }
        }).then(() => {
            this.showToast('Success', 'Contact created successfully!', 'success');
            this.name = this.email = this.phone = '';
        }).catch(error => {
            this.showToast('Error', error.body.message, 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
