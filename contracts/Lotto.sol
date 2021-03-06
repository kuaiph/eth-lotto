pragma solidity ^0.4.11;

contract Lotto {
  address public owner;
  address[] public participants;
  address public winner;

  uint prize_total = 0 ether;
  uint ticket_price = 0 ether;
  uint prize_tally = 0 ether;

  event ticket_bought(
    uint _prize_tally
  );

  /* @TODO Remove: For debugging */
  event console_log(
    uint _log
  );

  event winner_chosen(
    address winner
  );

  function Lotto(uint _prize_total, uint _ticket_price){
    owner = msg.sender;
    winner = 0x0000000000000000000000000000000000000000;
    prize_total = _prize_total;
    ticket_price = _ticket_price;
  }

  function buy_ticket() public payable returns(bool){
    if(prize_tally < prize_total){
      participants.push(msg.sender);
      prize_tally += msg.value;

      ticket_bought(prize_tally);

      if(prize_tally == prize_total) determine_winner();
    }
  }

  function determine_winner() private{
    // Find a winner randomly
    winner = participants[1];
    // Pay them
    winner_chosen(winner);
  }

  function get_participants() constant public returns(address[]){
    return participants;
  }

  function get_tally() constant public returns(uint){
    return prize_tally;
  }

}
