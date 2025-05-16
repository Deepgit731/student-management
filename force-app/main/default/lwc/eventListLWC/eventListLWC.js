import { LightningElement } from 'lwc';
import getFilteredEvents from '@salesforce/apex/EventController.getFilteredEvents';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EventListLWC extends LightningElement {
    events = [];
    error;
    showRegistrationForm = false;
    selectedType = 'All';
    searchKey = '';
    currentEventId;
    isLoading = false;

    searchTimeout;

    typeOptions = [
        { label: 'All', value: 'All' },
        { label: 'Internal', value: 'Internal' },
        { label: 'External', value: 'External' }
    ];

    connectedCallback() {
        this.fetchEvents();
    }

    fetchEvents() {
        this.isLoading = true;
        getFilteredEvents({
            typeFilter: this.selectedType,
            searchKey: this.searchKey
        })
        .then(result => {
            this.events = result;
            this.error = undefined;
        })
        .catch(error => {
            this.events = [];
            this.error = error.body?.message || 'Unknown error occurred';
        })
        .finally(() => {
            this.isLoading = false;
        });
    }

    handleTypeChange(event) {
        this.selectedType = event.target.value;
        this.fetchEvents();
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value;

        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
        }

        this.searchTimeout = setTimeout(() => {
            this.fetchEvents();
        }, 300);
    }

    handleRegister(event) {
        this.currentEventId = event.target.dataset.id;
        this.showRegistrationForm = true;
    }

    closeRegistrationForm() {
        this.showRegistrationForm = false;
    }

    handleRegistrationSuccess() {
        this.showToast('Success', 'You have successfully registered for the event!', 'success');
        this.closeRegistrationForm();
        this.fetchEvents();  // Refresh events to update status
    }

    handleRegistrationError(event) {
        const message = event.detail.message;
        let userMessage = 'Registration failed. Please try again.';

        if (message.includes('already registered')) {
            userMessage = 'You are already registered for this event.';
        } else if (message.includes('full')) {
            userMessage = 'This event is already full.';
        }

        this.showToast('Error', userMessage, 'error');
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title,
            message,
            variant
        }));
    }
}
