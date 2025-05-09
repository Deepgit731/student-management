import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class StudentForm extends LightningElement {
    handleSuccess() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Student created successfully!',
                variant: 'success'
            })
        );

        // Notify parent to refresh the list
        this.dispatchEvent(new CustomEvent('studentadded'));
    }
}
