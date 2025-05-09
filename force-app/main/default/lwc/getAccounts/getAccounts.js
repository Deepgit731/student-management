import { LightningElement ,wire} from 'lwc';
import getAcc from '@salesforce/apex/accountController.getLatestAccounts';

export default class GetAccounts extends LightningElement {
    accounts;

    @wire(getAcc)
    wiredAccounts({data,error}){
        if(data){
            this.accounts=data;
        }
    }
}