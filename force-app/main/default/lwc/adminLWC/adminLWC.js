import { LightningElement, track, wire } from 'lwc';
import getEvents from '@salesforce/apex/EventController.getEvents';
import isAdminUser from '@salesforce/apex/EventController.isAdminUser';
import deleteEvent from '@salesforce/apex/EventController.deleteEvent';
import getRegistrationsForEvent from '@salesforce/apex/EventController.getRegistrationsForEvent';
import cancelRegistration from '@salesforce/apex/EventController.cancelRegistration';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class AdminEventManagerLWC extends LightningElement {
    @track isAdmin = false;
    @track events = [];
    @track selectedEventId;
    @track showForm = false;
    @track showRegistrationsModal = false;
    @track registrations = [];

    wiredEventsResult;

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Date', fieldName: 'Event_Date__c', type: 'date' },
        { label: 'Type', fieldName: 'Event_Type__c' },
        { label: 'Location', fieldName: 'Location__c' },
        { label: 'Max Attendees', fieldName: 'Max__c', type: 'number' },
        { label: 'Registered', fieldName: 'Current_Attendees__c', type: 'number' },
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'Edit', name: 'edit' },
                    { label: 'Delete', name: 'delete' },
                    { label: 'View Registrations', name: 'view_registrations' }
                ]
            }
        }
    ];

    registrationColumns = [
        { label: 'Attendee Name', fieldName: 'attendeeName' },
        { label: 'Registration Name', fieldName: 'Name' },
        { label: 'Registered On', fieldName: 'Registered_on__c', type: 'date' },
        { label: 'Status', fieldName: 'Status__c' }, // New column
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'Cancel', name: 'delete' } // Keep action name 'delete' for reuse
                ]
            }
        }
    ];

    @wire(isAdminUser)
    checkAdmin({ data, error }) {
        if (data) {
            this.isAdmin = data;
        } else if (error) {
            this.showToast('Error', 'Failed to verify admin access', 'error');
        }
    }

    @wire(getEvents)
    wiredEvents(result) {
        this.wiredEventsResult = result;
        if (result.data) {
            this.events = result.data;
        } else if (result.error) {
            this.showToast('Error', 'Failed to load events', 'error');
        }
    }

    openNewForm() {
        this.selectedEventId = null;
        this.showForm = true;
    }

    closeForm() {
        this.showForm = false;
    }

    get formTitle() {
        return this.selectedEventId ? 'Edit Event' : 'New Event';
    }

    handleRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;

        if (action === 'edit') {
            this.selectedEventId = row.Id;
            this.showForm = true;
        } else if (action === 'delete') {
            deleteEvent({ eventId: row.Id })
                .then(() => {
                    this.showToast('Success', 'Event deleted', 'success');
                    return refreshApex(this.wiredEventsResult);
                })
                .catch(error => {
                    const message = error.body?.message || 'Unknown error during deletion.';
                    this.showToast('Error', message, 'error');
                    console.error('deleteEvent error:', error);
                });
        } else if (action === 'view_registrations') {
            this.selectedEventId = row.Id;
            getRegistrationsForEvent({ eventId: row.Id })
    .then(result => {
        const filtered = result.filter(reg => reg.Status__c === 'Registered');

        this.registrations = filtered.map(reg => ({
            ...reg,
            attendeeName: reg.Attendee__r?.Name || 'Unknown',
            statusClass: 'slds-text-color_success'
        }));
        this.showRegistrationsModal = true;
    })
                .catch(error => {
                    this.showToast('Error', 'Failed to load registrations', 'error');
                    console.error('getRegistrationsForEvent error:', error);
                });
        }
    }

    // 🚨 This now cancels registration instead of deleting
    handleRegistrationRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;

        if (action === 'delete') {
            cancelRegistration({ registrationId: row.Id })
                .then(() => {
                    this.showToast('Success', 'Registration status updated to Cancelled', 'success');

                    // Update local registration list
                    this.registrations = this.registrations.map(reg => {
                        if (reg.Id === row.Id) {
                            return { ...reg, Status__c: 'Cancelled' };
                        }
                        return reg;
                    });
                })
                .catch(error => {
                    const message = error.body?.message || 'Error updating registration status';
                    this.showToast('Error', message, 'error');
                    console.error('cancelRegistration error:', error);
                });
        }
    }

    handleSuccess() {
        this.showToast('Success', 'Event saved', 'success');
        this.showForm = false;
        return refreshApex(this.wiredEventsResult);
    }

    closeRegistrationsModal() {
        this.showRegistrationsModal = false;
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
