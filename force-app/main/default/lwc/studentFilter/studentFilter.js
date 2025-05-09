import { LightningElement, track } from 'lwc';

export default class StudentFilter extends LightningElement {
    @track selectedGrade = '';
    gradeOptions = [
        { label: 'All', value: '' },
        { label: '1st', value: '1st' },
        { label: '2nd', value: '2nd' },
        { label: '3rd', value: '3rd' },
        { label: '4th', value: '4th' },
        { label: '5th', value: '5th' }
    ];

    handleChange(event) {
        this.selectedGrade = event.detail.value;
        this.dispatchEvent(new CustomEvent('gradechange', {
            detail: this.selectedGrade
        }));
    }
}
