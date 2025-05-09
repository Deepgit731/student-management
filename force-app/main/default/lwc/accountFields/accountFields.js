import { LightningElement,api,wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS = ['Account.Name', 'Account.Industry', 'Account.Phone'];
export default class AccountFields extends LightningElement {
    @api recordId; 
    account;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredAccount({ data, error }) {
        if (data) {
            this.account = {
                name: data.fields.Name.value,
                industry: data.fields.Industry.value,
                phone: data.fields.Phone.value
            };
        } else if (error) {
            console.error(error);
        }
    }
}
