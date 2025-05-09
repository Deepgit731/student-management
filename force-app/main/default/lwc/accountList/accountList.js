import { LightningElement,track } from 'lwc';
import searchContacts from '@salesforce/apex/accountController.fetchAccounts';

export default class AccountList extends LightningElement {

    @track searchKey = '';
    @track accounts;

    handleSearchKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        searchContacts({ searchKey: this.searchKey })
            .then(result => {
                this.accounts = result;
                this.error = undefined;
            })
    }
}