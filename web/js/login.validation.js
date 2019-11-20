/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#pizzaOrderingLogin").validate({
        rules: {
            userEmail: {
                required: true,
                email: true
            },
            userPwd: 'required'
        },
        messages: {
            userEmail: {
                required: 'Please enter an email address!',
                email: 'Please enter a valid email address!'
            },
            userPwd: 'Please enter a password!'
        }
    });
});
