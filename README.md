Patent link - Blockchain project

Ruben Seror - 1815399
Edoardo Giuggioloni - 1881780
Carolina Proietti - 1808759
Paolo Marchignoli - 1885820

dAPP deposito di brevetti 

Requisiti funzionali:
  - Deposito di brevetto (nazionale) tramite pagamento di token (fungible token) -> sistema fornisce NFT associata a brevetto
  - Acquistare licenza utilizzo di un brevetto tramite pagamento di token:
    licenza esclusiva: cambia owner della nft

Requisiti funzionali (vedere situazione per esame):
  - Possibilità di acquistare licenza unica o non esclusiva di un brevetto (Utility Token?)
  - 


 Funzionalità possibili:
  - Creazione di Token (NFT?) specifico per ogni brevetto
  - Test di brevetti tramite API
  - Verifica identità reali utenti
  - Possibilità di estendere validità a livello internazionale del brevetto
  - solo utente verificato può fare azioni di vendita



significato cartelle create con truffle:
  - contracts: dove mettere gli smart contracts
  - migration: file (node.js) dove spiegare come fare deploy smart contracts nella blockchain
  - test: test file per smart contracts 


possibili attributi brevetto:
  - titolo
  - id
  - timestamp deposito
  - data di scadenza
  - descrizione
  - owner
  - categoria

  licenza esclusiva: un solo concessionario ha il diritto di utilizzare la tecnologia brevettata, la quale non può essere usata dal proprietario del brevetto
  licenza unica: un solo concessionario, unitamente al proprietario del brevetto, ha il diritto di utilizzare la tecnologia brevettata
  licenza non esclusiva:diversi concessionari, verosimilmente in aree diverse, e il titolare del brevetto hanno il diritto di utilizzare la tecnologia brevettata.


risorse utili:
  - truffle: 
    https://www.youtube.com/watch?v=JXa_Y-17Oj4 initialize truffle, ganache, deploying and testing contracts
    https://www.youtube.com/watch?v=FYhZPovlGZQ&ab_channel=WebDevCody connect UI to solidity contract

  - solidity: 
    https://www.youtube.com/watch?v=AYpftDFiIgk smart contract programming, 2 parts of the video regard connect UI to smart contract
    https://www.youtube.com/watch?v=M576WGiDBdQ&ab_channel=freeCodeCamp.org dapp using solidity and python
    https://www.youtube.com/watch?v=gyMwXuJrbJQ&ab_channel=freeCodeCamp.org dapp using solidity and js (also contains info about ERC20 - Token - and info about ERC721 - NFT -  )


    Frontend:
    schermata home
    connessione con wallet tramite metamask


    processo creazione nft:
    da frontend carico file brevetto su ipfs tramite pinata
    pinata restituisce hash che corrisponde tokenURI
    salvare tokenURI su blockchain nella generazione NFT


    checklist:
    - [ ] nft
    - [x] token 