import { LightningElement, track } from 'lwc';
import searchContacts from '@salesforce/apex/ContactController.searchContacts';

export default class GetContact extends LightningElement {
    @track searchKey = '';
    @track contacts;
    isLoading = false;
    error;

    handleKeyChange(event) {
        this.searchKey = event.target.value;
        this.searchContactsHandler();
    }

    searchContactsHandler() {
        this.isLoading = true;
        searchContacts({ searchKey: this.searchKey })
            .then(result => {
                if (result) {
                    this.contacts = result;
                    this.error = undefined;
                } else {
                    this.contacts = undefined;
                    this.error = 'No data found';
                }
                this.isLoading = false;
            });
    }
}