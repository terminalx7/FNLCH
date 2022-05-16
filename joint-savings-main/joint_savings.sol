/*
Joint Savings Account
---------------------

*/

pragma solidity ^0.5.0;

// Defines a new contract named `JointSavings`
contract JointSavings {

    /*
    Defines the following variables inside the new contract:
    - Two variables of type `address payable` named `accountOne` and `accountTwo`
    - A variable of type `address public` named `lastToWithdraw`
    - Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`.
    */
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    /*
    Defines a function named **withdraw** that will accept two arguments:
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
    function withdraw(uint amount, address payable recipient) public {

        /*
        Defines a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.
        */
        require (recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        /*
        Defines a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        */
        require (address(this).balance >= amount, "Insufficient funds!");

        /*
        Adds an `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal, then sets it to the current value of `recipient`.
        */
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }

        // Calls the `transfer` function of the `recipient` and passes it the `amount` to transfer as an argument.
        return recipient.transfer(amount); 

        // Sets  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Calls the `contractBalance` variable and sets it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // Defines a `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        Calls the `contractBalance` variable and sets it equal to the balance of the contract by using `address(this).balance`.
        */
        contractBalance = address(this).balance;
    }

    /*
    Defines a `public` function named `setAccounts` that receives two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Adds the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {}
}
