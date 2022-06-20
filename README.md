<div align="center">
    <img src="https://i.ibb.co/b1yxnF0/1-17.png?raw=true" width="150px" alt="BitnSats Logo"/>
</div>

<h3 align="center">BitsnSats multiplayer tic-tac-toe lightning game, allowing friends to go head to head with some sats on the line.</h3>

<div align="center">
    <img src="https://i.ibb.co/gFSMxZS/FVsc-Bd-Mag-AAv-Yed.jpg?raw=true" alt="Flutter and Blockchain Logo"/>
</div>

<div align="center">

# [BitsnSats](https://bitsnsats.netlify.app/#/)

</div>

# Multiplayer Game (Two Player Occupancy) 🎮👬
![](https://i.ibb.co/SNmymYd/Bitn-Sats-STW2.png)

So before talking about **Bits and Sats**, I would like to talk a little bit about Multiplayer Game which has 2 player occupancy. There are certain fundamental functionalities which needs to be there in place irrespective of the game.

For example:
- There needs to be a functionality were the players can easily create rooms, after creating the room the system gonna give a room-id to them.

- There needs to be a functionality were other players can easily join the room by adding the room-id.

- Since the occupancy of our game is 2 players, there needs to be a functionality were 2+N players were n>=1 cannot join the ongoing game or/else room, because if they join the game or/else room, there will be disturbance between the two players who are actually playing the game.

- We also need to have a functionality were we can easily keep track of the points of both of the players(scoreboard) and depending on certain conditions gonna declare who is the winner of the game.

Super easy ! 🏃💨

# Idea 💡
![](https://i.ibb.co/NZtVFPG/Bitn-Sats-STW2-1.png)

But the idea I have in my mind for bits and sats is :

- Before creating the room or before joining the room both of the players needs to deposit certain amount of sats into the system.

- So when the sats are successfully deposited then only, the players can create room or join the room and play the game.

# Winner 🏆
![](https://i.ibb.co/wgnFFpp/Bitn-Sats-STW2-2.png)

In the end the winner of the game will receive the final amount of deposited sats by both of the players. i.e

```dart
playerADeposited sats + playerBDepositedSats = winningAmount
```

OR

```dart
(playerADepositedSats + playerBDepositedSats) - someFees = winningAmount 
```

# Problem - Holding Sats 🛅
![](https://i.ibb.co/SJkH1wS/Bitn-Sats-STW2-3.png)

But the problem here is:

- While both of the players are playing the game, we need some kind of escrow based payment system to hold our funds.

- And also when one of the player wins the game we need some function to trigger which can easily send the payment to the winner of the game.

# Some Great Solutions to Implement BitsnSats 🎢
1. Creating withdraw links and displaying the withdraw links to the winner.

2. Using LightningEscrow.io API


[](https://lh6.googleusercontent.com/7EUVvI_C6m547BBsa5bLv8UVPYwmVSLIcaJS81X4tfKcQUQ9tfhMR1hpkCLFBocqWSIe7eZZREegZA06Bttloc5G3D5nkpSJW0vKCflIjPREYbKk4hWRH_pWzn3731wAvteJPgcO8gBlENlFCegT7w)

So, I discussed this idea earlier in STW discord mixer maker chit chat one.

Where johns suggested me that we can do something like, instead of depositing the funds the users can create withdraw links which will be stored in a database initially and not visible to any of the players, and the player who wins the game will see both of the withdraw links so that he/she can easily deposit the funds into his/her wallet.

Or

The other solution could be to use lightningEscrow API.

But guess what, I'm not using any of this stuff currently in my project. 😎

# Technology Stack 💢
![](https://i.ibb.co/9n38Tg3/Bitn-Sats-STW2-4.png)

So the technology stack used for bits and sats is:

- **Flutter** framework for front-end development with which we can deploy our applications for multiple platforms with single codebase super easy!.

- **Nodejs**, **Expressjs**, **MongoDB** in combination with each other for the backend.

- **Socketio** for realtime emitting and listening events.

- Some **WebLN** functions, **LNurlPay** requestInvoice(), **LNbits** API

# Current BitsnSats Implementation 🚀
![](https://i.ibb.co/RhG2bdG/Bitn-Sats-STW2-5.png)

So, When the user browse _bitsnsats_ website initially, it will check that the user's browser has the lightning wallet installed on it or not.

```dart
if (window.webln != null) {
            return const MainMenuScreen();
          } else {
            return const NoWalletScreen();
}
```

If the *webln* value is equals to *null*, which means that the lightning wallet extension is not installed in user's browser were it will show `NoWalletScreen()`.

But when the *webln* value is not equals to *null*, which means that the lightning wallet is installed were it will be showing `MainMenuScreen()` to the user.

Going further with the `MainMenuScreen()` which has three *ElevatedButtons* into it:
- **Create Room**
- **Join Room**
- **Instruction**

Also one thing to remember here, when the webln value is not equals to null in the `MainMenuScreen()` it will do

```dart
await window.webln.enable();
```

So by calling the above function it will prompt the user for permission to use WebLN capabilities of the browser.

Also for interacting with WebLN APIs we first need to enable the provider otherwise the other webln based functions will not work and will throw error.

# Deposit Sats Screen 🛅
![](https://i.ibb.co/D98BDVT/Bitn-Sats-STW2-6.png)

So when the user clicks on _Create Room_ or _Join Room_ (Elevated Buttons), it will open `DepositSatsScreen()` screen initially.

Behind the scene it will get the invoice of lnbits external wallet which will going to hold funds for the user.

When the user clicks on the _Deposit button_ the invoice of the lnbits external wallet will be passed to `sendPayment` method.

The `sendPayment` will do:

```dart
try {
        const res = await window.webln.sendPayment(invoice);
        window.paymentState = {
            preimage: res["preimage"],
            paymentHash: res["paymentHash"]
        }
    }
    catch(e) {
        showError(e);
}
```

It will store the `preimage` and `paymentHash` for further use case (validation and verification). And redirect the user to `CreateRoomScreen()`, if the user wants to create the room or `JoinRoomScreen()`, if the user wants to join the room.

# Invoice Paid or Not ❓
![](https://i.ibb.co/PTPWShK/Bitn-Sats-STW2-7.png)

To check that the user successfully paid the invoice or not, we need to do a **GET** request by passing the `paymentHash` that we received and stored in the previous step by `sendPayment` method.

The endpoint(`/api/v1/payments/<payment_hash>`) gonna give a response back to us which is like `paid: true` (which means that the user successfully deposited the specified amount) or `paid: false` (which means that the user did not deposited the specified amount)

```dart
if (value["paid"] == true) {
        invoicePaid = true;
        createRoom(_walletAddressController.text);
      } else {
        invoicePaid = false;
}

if (value["paid"] == true) {
            invoicePaid = true;
            joinRoom(_walletAddressController.text, _gameIdController.text);
      } else {
            invoicePaid = false;
}
```

If the response received paid is true, then only it will create the room or join the room.

# Paying Winner ⚡
![](https://i.ibb.co/jWXbQ3M/Bitn-Sats-STW2-8.png)

Now to pay the winner of the game, what implemented is, the `winnerWalletAddress` and the `winningAmount` will be passed to the `LNURLPay.RequestInvoice` as:

```dart
await LnurlPay.requestInvoice({
      lnUrlOrAddress: winnerWalletAddress,
      tokens: winningAmount,
      comment: comment,
});
```

It will generate the invoice for the winner, after the invoice is generated, it will pass the invoice to `payInvoice` method which will do a **POST** request to LNBits api which will going to pay the user the `winningAmount` easily.

That's it from my side for BitsnSats, Thank you so much !