import { LightningElement, track } from 'lwc';
import getStudents from '@salesforce/apex/StudentController.getStudents';

export default class StudentManager extends LightningElement {
    @track students = [];

    connectedCallback() {
        this.fetchStudents();
    }

    fetchStudents(grade = '') {
        getStudents({ grade })
            .then(result => {
                this.students = result;
            })
            .catch(error => {
                console.error('Error fetching students:', error);
            });
    }

    handleStudentAdded() {
        this.fetchStudents();
    }

    handleGradeChange(event) {
        this.fetchStudents(event.detail);
    }
}
