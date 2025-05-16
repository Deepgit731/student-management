import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EventRegistrationForm extends LightningElement {
    handleSuccess() {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Registration successfully!',
                    variant: 'success'
                })
            );
            this.dispatchEvent(new CustomEvent('registered'));
        }
}
