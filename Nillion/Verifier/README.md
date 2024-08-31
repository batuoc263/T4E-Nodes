
# Setting Up a Verifier for Nillion

Follow these steps to set up a verifier on Nillion.

## 1. Ensure Your Keplr Wallet Has Some NIL

Go to the [Nillion Faucet](#) to obtain NIL in your Keplr wallet.

## 2. Installing Docker

To install the accuser and verify secret storage, you will first need to install Docker for your respective platform. Follow the instructions [here](#) to install Docker.

## 3. Verifying Docker Installation

After installing Docker, verify the installation by checking the Docker version. Run the following command in your terminal:

```bash
docker --version
```
This should return a version number like:
```bash
Docker version 27.1.1, build 63125853e3
```
Next, ensure Docker is working correctly by running a simple container:

```bash
docker container run --rm hello-world
```
This will print out `Hello from Docker!` in the terminal output.

## 4. Getting the Accuser Image
To run the accuser, pull the image from the Nillion repo on Docker Hub:

```bash
docker pull nillion/retailtoken-accuser:v1.0.0
```

## 5. Initialising the Accuser
Create a local directory to store the accuser's state:

```bash
mkdir -p nillion/accuser
```
Then, initialize the accuser in the mounted directory:

```bash
docker run -v ./nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 initialise
```
This will output the details needed to register the accuser on the website:
```bash
AccountId: Nillion address of the accuser
PublicKey: Public Key of the accuser
Note: The accuser will store the credentials in a file called credentials.json in the folder that was created. If you lose this file, you will lose access to the keys/address of the accuser.
```

Then, go to https://verifier.nillion.com/verifier , enter AccountId and PublicKey to submit

## 6. Funding the Accuser
To make accusations on the Nilchain, the accuser account will need to be funded with NIL. You can get NIL from the Nillion Faucet.

The Nillion address of the accuser is the one generated in the previous step (not your Keplr wallet address).

## 7. Running the Accuser
WAIT 30-60 MINUTES BEFORE CONTINUING WITH THIS STEP. The secret verification process requires this waiting period before fully registering the accuser.

Once you have the registration details, you can run the accuser in the same directory. Ensure that your accuser has some funds by going to the Nillion Faucet.

Run the following command:

```bash
docker run -v ./nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 accuse --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com" --block-start 5200558
```
