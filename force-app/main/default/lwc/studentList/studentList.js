import { LightningElement, api } from 'lwc';

export default class StudentList extends LightningElement {
    @api students;

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Grade', fieldName: 'Grade__c' }
    ];
}
