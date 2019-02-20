//
//  sdkTests.m
//  sdkTests
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dlx. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <sdk_ios.framework/Headers/sdk_ios.h>

@interface sdkTests : XCTestCase

@end

@implementation sdkTests
SDK *sdk;

- (void)setUp {
    [super setUp];
    sdk = [[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    [self checkAccountValid];
//    [self createNewAccount];
//    [self getAccountInfo];
//    [self getAccountNonce];
//    [self getAccountBalance];
//    [self getAccountAssets];
//    [self getAccountMetadata];
//    [self getAssetInfo];
//    [self activateAccount];
//    [self setAccountMetadata];
//    [self setAccountPrivilege];
    [self issueAsset];
//    [self sendAsset];
//    [self sendBU];
//    [self issueCtp10Token];
//    [self assignCtp10Token];
//    [self transferCtp10Token];
//    [self transferFromCtp10Token];
//    [self approveCtp10Token];
//    [self changeTokenOwnerCtp10Token];
//    [self checkValidCtp10Token];
//    [self getCtp10TokenAllowance];
//    [self getCtp10TokenInfo];
//    [self getCtp10TokenName];
//    [self getCtp10TokenSymbol];
//    [self getCtp10TokenDecimals];
//    [self getCtp10TokenTotalSupply];
//    [self getCtp10TokenBalance];
//    [self checkContractValid];
//    [self getContractInfo];
//    [self getContractAddress];
//    [self callContract];
//    [self createContract];
//    [self invokeContractByAsset];
//    [self invokeContractByBU];
//    [self getTransactionByHash];
//    [self checkBlockStatus];
//    [self getTransactionsByBlockNumber];
//    [self getLatestBlockNumber];
//    [self getBlockInfo];
//    [self getBlockLatestInfo];
//    [self getBlockValidators];
//    [self getLatestBlockValidators];
//    [self getLatestBlockReward];
//    [self getBlockFees];
//    [self getBlockLatestFees];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) checkAccountValid {
    AccountService *accountService = [sdk getAccountService];
    AccountCheckValidRequest *request = [AccountCheckValidRequest new];
    [request setAddress:@"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    AccountCheckValidResponse *response = [accountService checkValid: nil];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) createNewAccount {
    AccountService *accountService = [sdk getAccountService];
    AccountCreateResponse *response = [accountService create];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountInfo {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [sdk getAccountService];
    AccountGetInfoRequest *request = [AccountGetInfoRequest new];
    [request setAddress : address];
    AccountGetInfoResponse *response = [accountService getInfo : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountNonce {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [sdk getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];
    AccountGetNonceResponse *response = [accountService getNonce : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountBalance {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [sdk getAccountService];
    AccountGetBalanceRequest * request = [AccountGetBalanceRequest new];
    [request setAddress : address];
    AccountGetBalanceResponse *response = [accountService getBalance : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountAssets {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [sdk getAccountService];
    AccountGetAssetsRequest * request = [AccountGetAssetsRequest new];
    [request setAddress : address];
    AccountGetAssetsResponse *response = [accountService getAssets : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountMetadata {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [sdk getAccountService];
    AccountGetMetadataRequest * request = [AccountGetMetadataRequest new];
    [request setAddress : address];
    AccountGetMetadataResponse *response = [accountService getMetadata : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAssetInfo {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    NSString *code = @"TST";
    NSString *issuer = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AssetGetInfoRequest *request = [AssetGetInfoRequest new];
    [request setAddress : address];
    [request setCode : code];
    [request setIssuer : issuer];
    
    AssetService *assetService = [sdk getAssetService];
    AssetGetInfoResponse *response = [assetService getInfo : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) activateAccount {
    AccountService *accountService = [sdk getAccountService];
    // Create an inactive account
    AccountCreateResponse *activateResponse = [accountService create];
    XCTAssert(activateResponse.errorCode == 0, @"%@", activateResponse.errorDesc);
    
    // Build AccountActivateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    NSString *destAddress = activateResponse.result.address;
    int64_t initBalance = 10000000;
    AccountActivateOperation *operation = [AccountActivateOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setDestAddress : destAddress];
    [operation setInitBalance : initBalance];
    [operation setMetadata : @"activate account"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 68;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountMetadata {
    // Build AccountSetMetadataOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    NSString *key = @"setMetadataTest";
    NSString *value = @"201808";
    AccountSetMetadataOperation *operation = [AccountSetMetadataOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setKey : key];
    [operation setValue : value];
    [operation setMetadata : @"activate account"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 73;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountPrivilege {
    // Build AccountSetPrivilegeOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountSetPrivilegeOperation *operation = [AccountSetPrivilegeOperation new];
    [operation setSourceAddress : sourceAddress];
    SignerInfo *signer = [SignerInfo new];
    [signer setAddress : @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB"];
    [signer setWeight : 2];
    [operation addSigner : signer];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 74;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueAsset {
    // Build AssetIssueOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Asset code
    NSString *code = @"RV";
    // Asset amount
    int64_t amount = 9223372036854775807;
    AssetIssueOperation *operation = [AssetIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setCode: code];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 129;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendAsset {
    // Build AssetSendOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Destination account
    NSString *destAddress = @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB";
    // Asset code
    NSString *code = @"TST";
    // Asset issuer
    NSString *issuer = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Asset amount
    int64_t amount = 100000;
    AssetSendOperation *operation = [AssetSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setCode: code];
    [operation setIssuer: issuer];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendBU {
    // Build BUSendOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Destination account
    NSString *destAddress = @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB";
    // BU amount
    int64_t amount = 1000000;
    BUSendOperation *operation = [BUSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueCtp10Token {
    // Build Ctp10TokenIssueOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The initialization BU of the contract to be created
    int64_t initBalance = [Tools BU2MO: 0.1];
    NSLog(@"%lld", initBalance);
    // The decimals of token amount
    int32_t decimals = 8;
    // The token name
    NSString *name = @"CTP";
    // The token supply
    NSString *supply = @"1000000000000";
    // The token symbol
    NSString *symbol = @"CTP";
    
    Ctp10TokenIssueOperation *operation = [Ctp10TokenIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDecimals: decimals];
    [operation setInitBalance: initBalance];
    [operation setName: name];
    [operation setSymbol: symbol];
    [operation setSupply: supply];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) assignCtp10Token {
    // Build Ctp10TokenAssignOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be assign token
    NSString *destAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenAssignOperation *operation = [Ctp10TokenAssignOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) transferCtp10Token {
    // Build Ctp10TokenTransferOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be assign token
    NSString *destAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenTransferOperation *operation = [Ctp10TokenTransferOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) transferFromCtp10Token {
    // Build Ctp10TokenTransferFromOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to send token
    NSString *fromAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to be assign token
    NSString *destAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenTransferFromOperation *operation = [Ctp10TokenTransferFromOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setFromAddress: fromAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) approveCtp10Token {
    // Build Ctp10TokenApproveOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be allowed to spend token
    NSString *spender = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenApproveOperation *operation = [Ctp10TokenApproveOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setSpender: spender];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) changeTokenOwnerCtp10Token {
    // Build Ctp10TokenChangeOwnerOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token owner
    NSString *tokenOwner = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    Ctp10TokenChangeOwnerOperation *operation = [Ctp10TokenChangeOwnerOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setTokenOwner: tokenOwner];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) checkValidCtp10Token {
    Ctp10TokenCheckValidRequest *request = [Ctp10TokenCheckValidRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenCheckValidResponse *response = [service checkValid: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenAllowance {
    Ctp10TokenAllowanceRequest *request = [Ctp10TokenAllowanceRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    [request setTokenOwner: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    [request setSpender: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenAllowanceResponse *response = [service allowance: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenInfo {
    Ctp10TokenGetInfoRequest *request = [Ctp10TokenGetInfoRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenName {
    Ctp10TokenGetNameRequest *request = [Ctp10TokenGetNameRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetNameResponse *response = [service getName: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenSymbol {
    Ctp10TokenGetSymbolRequest *request = [Ctp10TokenGetSymbolRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetSymbolResponse *response = [service getSymbol: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenDecimals {
    Ctp10TokenGetDecimalsRequest *request = [Ctp10TokenGetDecimalsRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetDecimalsResponse *response = [service getDecimals: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenTotalSupply {
    Ctp10TokenGetTotalSupplyRequest *request = [Ctp10TokenGetTotalSupplyRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetTotalSupplyResponse *response = [service getTotalSupply: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getCtp10TokenBalance {
    Ctp10TokenGetBalanceRequest *request = [Ctp10TokenGetBalanceRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    [request setTokenOwner: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    
    Ctp10TokenService *service = [sdk getCtp10TokenService];
    Ctp10TokenGetBalanceResponse *response = [service getBalance: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) checkContractValid {
    ContractCheckValidRequest *request = [ContractCheckValidRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];
    
    ContractService *service = [sdk getContractService];
    ContractCheckValidResponse *response = [service checkValid: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getContractInfo {
    ContractGetInfoRequest *request = [ContractGetInfoRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];
    
    ContractService *service = [sdk getContractService];
    ContractGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getContractAddress {
    ContractGetAddressRequest *request = [ContractGetAddressRequest new];
    [request setHash: @"44246c5ba1b8b835a5cbc29bdc9454cdb9a9d049870e41227f2dcfbcf7a07689"];
    
    ContractService *service = [sdk getContractService];
    ContractGetAddressResponse *response = [service getAddress: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) callContract {
    ContractCallRequest *request = [ContractCallRequest new];
    [request setCode : @"\"use strict\";log(undefined);function query() { getBalance(thisAddress); }"];
    [request setFeeLimit : 1000000000];
    [request setOptType : 2];
    
    ContractService *service = [sdk getContractService];
    ContractCallResponse *response = [service call : request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) createContract {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Contract account initialization BU，the unit is MO，and 1 BU = 10^8 MO
    int64_t initBalance = [Tools BU2MO: 0.01];
    // Contract code
    NSString *payload = @"\n          \"use strict\";\n          function init(bar)\n          {\n            /*init whatever you want*/\n            return;\n          }\n          \n          function main(input)\n          {\n            let para = JSON.parse(input);\n            if (para.do_foo)\n            {\n              let x = {\n                \'hello\' : \'world\'\n              };\n            }\n          }\n          \n          function query(input)\n          { \n            return input;\n          }\n        ";
    // The contract account address of contract token code
    NSString *initInput = @"";
    ContractCreateOperation *operation = [ContractCreateOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setInitBalance: initBalance];
    [operation setPayload: payload];
    [operation setInitInput: initInput];
    [operation setMetadata: @"create contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByAsset {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to receive the assets
    NSString *contractAddress = @"buQd7e8E5XMa7Yg6FJe4BeLWfqpGmurxzZ5F";
    // The asset code to be sent
    NSString *assetCode = @"TST";
    // The account address to issue asset
    NSString *assetIssuer = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByAssetOperation *operation = [ContractInvokeByAssetOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setCode: assetCode];
    [operation setIssuer: assetIssuer];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send asset and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByBU {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to receive the assets
    NSString *contractAddress = @"buQd7e8E5XMa7Yg6FJe4BeLWfqpGmurxzZ5F";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByBUOperation *operation = [ContractInvokeByBUOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send bu and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) getTransactionByHash {
    TransactionGetInfoRequest *request = [TransactionGetInfoRequest new];
    [request setHash: @"389d53e55929c997d22f25d3757b088e2e869403ac0f2d13712ba877762b3d45"];
    
    TransactionService *service = [sdk getTransactionService];
    TransactionGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) checkBlockStatus {
    BlockService *service = [sdk getBlockService];
    BlockCheckStatusResponse *response = [service checkStatus];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getTransactionsByBlockNumber {
    BlockGetTransactionsRequest *request = [BlockGetTransactionsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetTransactionsResponse *response = [service getTransactions: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getLatestBlockNumber {
    BlockService *service = [sdk getBlockService];
    BlockGetNumberResponse *response = [service getNumber];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockInfo {
    BlockGetInfoRequest *request = [BlockGetInfoRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockLatestInfo {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestInfoResponse *response = [service getLatestInfo];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockValidators {
    BlockGetValidatorsRequest *request = [BlockGetValidatorsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetValidatorsResponse *response = [service getValidators: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getLatestBlockValidators {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestValidatorsResponse *response = [service getLatestValidators];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockReward {
    BlockGetRewardRequest *request = [BlockGetRewardRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetRewardResponse *response = [service getReward: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getLatestBlockReward {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestRewardResponse *response = [service getLatestReward];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockFees {
    BlockGetFeesRequest *request = [BlockGetFeesRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetFeesResponse *response = [service getFees: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockLatestFees {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestFeesResponse *response = [service getLatestFees];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) buildBlobAndSignAndSubmit : (NSString *) privateKey : (NSString *) sourceAddress : (int64_t) nonce : (int64_t) gasPrice : (int64_t) feeLimit : (BaseOperation *)operation {
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : sourceAddress];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];
    
    TransactionService *transactionServer = [sdk getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    XCTAssert(buildBlobResponse.errorCode == 0, @"%@", buildBlobResponse.errorDesc);
    
    TransactionSignRequest *signRequest = [TransactionSignRequest new];
    [signRequest setBlob : buildBlobResponse.result.transactionBlob];
    [signRequest addPrivateKey : privateKey];
    TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
    XCTAssert(signResponse.errorCode == 0, @"%@", signResponse.errorDesc);
    
    TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
    [submitRequest setTransactionBlob : buildBlobResponse.result.transactionBlob];
    [submitRequest setSignatures : [signResponse.result.signatures copy]];
    TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
    XCTAssert(submitResponse.errorCode == 0, @"%@", submitResponse.errorDesc);
}

@end
