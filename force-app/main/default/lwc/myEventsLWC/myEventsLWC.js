import { LightningElement, track, wire } from 'lwc';
import getMyRegistrations from '@salesforce/apex/EventRegistrationController.getMyRegistrations';
import cancelRegistration from '@salesforce/apex/EventRegistrationController.cancelRegistration';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { label: 'Event Name', fieldName: 'eventName' },
    { label: 'Date', fieldName: 'eventDate', type: 'date' },
    { label: 'Location', fieldName: 'location' },
    { label: 'Status', fieldName: 'status' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Cancel',
            name: 'cancel',
            title: 'Cancel Registration',
            variant: 'destructive',
            iconName: 'utility:close',
            disabled: { fieldName: 'disableCancel' }
        }
    }
];

export default class MyEventsLWC extends LightningElement {
    @track registrations = [];
    @track error;
    columns = COLUMNS;

    @wire(getMyRegistrations)
    wiredRegistrations({ data, error }) {
        if (data) {
            this.registrations = data.map(item => ({
                Id: item.Id,
                eventName: item.Event__r.Name,
                eventDate: item.Event__r.Event_Date__c,
                location: item.Event__r.Location__c,
                status: item.Status__c,
                disableCancel: item.Status__c === 'Cancelled' 
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error.body?.message || 'Failed to fetch events.';
            this.registrations = [];
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'cancel') {
            this.cancelRegistration(row.Id);
        }
    }
    cancelRegistration(registrationId) {
        cancelRegistration({ registrationId })
            .then(() => {
                this.registrations = this.registrations.map(reg => {
                    if (reg.Id === registrationId) {
                        return { ...reg, status: 'Cancelled', disableCancel: true };
                    }
                    return reg;
                });

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Registration cancelled successfully.',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body?.message || 'Unable to cancel registration.',
                        variant: 'error'
                    })
                );
            });
    }
}
