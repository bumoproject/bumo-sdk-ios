//
//  SDKError.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "SDKError.h"

@implementation SDKError

+(NSString *) getDescription: (int32_t) errorCode {
    NSString *errorDesc;
    switch(errorCode) {
        case SUCCESS: errorDesc = @"success"; break;
        case ACCOUNT_CREATE_ERROR: errorDesc = @"Create account failed"; break;
        case INVALID_SOURCEADDRESS_ERROR: errorDesc = @"Invalid sourceAddress"; break;
        case INVALID_DESTADDRESS_ERROR: errorDesc = @"Invalid destAddress"; break;
        case INVALID_INITBALANCE_ERROR: errorDesc = @"InitBalance must be between 1 and max(int64)"; break;
        case SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR: errorDesc = @"SourceAddress cannot be equal to destAddress"; break;
        case INVALID_ADDRESS_ERROR: errorDesc = @"Invalid address"; break;
        case CONNECTNETWORK_ERROR: errorDesc = @"Fail to connect network"; break;
        case INVALID_ISSUE_AMOUNT_ERROR: errorDesc = @"Amount of the token to be issued must be between 1 and max(int64)"; break;
        case NO_ASSET_ERROR: errorDesc = @"The account does not have this asset"; break;
        case NO_METADATA_ERROR: errorDesc = @"The account does not have this metadata"; break;
        case INVALID_DATAKEY_ERROR: errorDesc = @"The length of key must be between 1 and 1024"; break;
        case INVALID_DATAVALUE_ERROR: errorDesc = @"The length of value must be between 0 and 256000"; break;
        case INVALID_DATAVERSION_ERROR: errorDesc = @"The version must be equal or bigger than 0"; break;
        case INVALID_MASTERWEIGHT_ERROR: errorDesc = @"MasterWeight must be between 0 and max(uint32)"; break;
        case INVALID_SIGNER_ADDRESS_ERROR:errorDesc = @"Invalid signer address"; break;
        case INVALID_SIGNER_WEIGHT_ERROR: errorDesc = @"Signer weight must be between 0 and max(uint32)"; break;
        case INVALID_TX_THRESHOLD_ERROR:  errorDesc = @"TxThreshold must be between 0 and max(int64)"; break;
        case INVALID_TYPETHRESHOLD_TYPE_ERROR: errorDesc = @"Operation type must be between 1 and 100"; break;
        case INVALID_TYPE_THRESHOLD_ERROR: errorDesc = @"TypeThreshold must be between 0 and max(int64)"; break;
        case INVALID_ASSET_CODE_ERROR: errorDesc = @"The length of asset code must be between 1 and 64"; break;
        case INVALID_ASSET_AMOUNT_ERROR: errorDesc = @"AssetAmount must be between 0 and max(int64)"; break;
        case INVALID_BU_AMOUNT_ERROR: errorDesc = @"BuAmount must be between 0 and max(int64)"; break;
        case INVALID_ISSUER_ADDRESS_ERROR: errorDesc = @"Invalid issuer address"; break;
        case NO_SUCH_TOKEN_ERROR: errorDesc = @"No such token"; break;
        case INVALID_TOKEN_NAME_ERROR: errorDesc = @"The length of token name must be between 1 and 1024"; break;
        case INVALID_TOKEN_SYMBOL_ERROR: errorDesc = @"The length of symbol must be between 1 and 1024"; break;
        case INVALID_TOKEN_DECIMALS_ERROR: errorDesc = @"Decimals must be between 0 and 8"; break;
        case INVALID_TOKEN_TOTALSUPPLY_ERROR: errorDesc = @"TotalSupply must be between 1 and max(int64)"; break;
        case INVALID_TOKENOWNER_ERROR: errorDesc = @"Invalid token owner"; break;
        case INVALID_TOKEN_SUPPLY_ERROR: errorDesc = @"Supply * (10 ^ decimals) must be between 1 and max(int64)"; break;
        case INVALID_CONTRACTADDRESS_ERROR: errorDesc = @"Invalid contract address"; break;
        case CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR: errorDesc = @"contractAddress is not a contract account"; break;
        case INVALID_TOKEN_AMOUNT_ERROR: errorDesc = @"TokenAmount must be between 1 and max(int64)"; break;
        case SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR: errorDesc = @"SourceAddress cannot be equal to contractAddress"; break;
        case INVALID_FROMADDRESS_ERROR: errorDesc = @"Invalid fromAddress"; break;
        case FROMADDRESS_EQUAL_DESTADDRESS_ERROR: errorDesc = @"FromAddress cannot be equal to destAddress"; break;
        case INVALID_SPENDER_ERROR: errorDesc = @"Invalid spender"; break;
        case PAYLOAD_EMPTY_ERROR: errorDesc = @"Payload cannot be empty"; break;
        case INVALID_LOG_TOPIC_ERROR: errorDesc = @"The length of log topic must be between 1 and 128"; break;
        case INVALID_LOG_DATA_ERROR: errorDesc = @"The length of one of log data must be between 1 and 1024"; break;
        case INVALID_CONTRACT_TYPE_ERROR: errorDesc = @"Invalid contract type"; break;
        case INVALID_NONCE_ERROR: errorDesc = @"Nonce must be between 1 and max(int64)"; break;
        case INVALID_GASPRICE_ERROR: errorDesc = @"GasPrice must be between 1000 and max(int64)"; break;
        case INVALID_FEELIMIT_ERROR: errorDesc = @"FeeLimit must be between 1 and max(int64)"; break;
        case OPERATIONS_EMPTY_ERROR: errorDesc = @"Operations cannot be empty"; break;
        case INVALID_CEILLEDGERSEQ_ERROR: errorDesc = @"CeilLedgerSeq must be equal or bigger than 0"; break;
        case OPERATIONS_ONE_ERROR: errorDesc = @"One of operations cannot be resolved"; break;
        case INVALID_SIGNATURENUMBER_ERROR: errorDesc = @"SignagureNumber must be between 1 and max(int32)"; break;
        case INVALID_HASH_ERROR: errorDesc = @"Invalid transaction hash"; break;
        case INVALID_BLOB_ERROR: errorDesc = @"Invalid blob"; break;
        case PRIVATEKEY_NULL_ERROR: errorDesc = @"PrivateKeys cannot be empty"; break;
        case PRIVATEKEY_ONE_ERROR: errorDesc = @"One of privateKeys is invalid"; break;
        case SIGNDATA_NULL_ERROR: errorDesc = @"SignData cannot be empty"; break;
        case INVALID_BLOCKNUMBER_ERROR: errorDesc = @"BlockNumber must be bigger than 0"; break;
        case PUBLICKEY_NULL_ERROR: errorDesc = @"PublicKey cannot be empty"; break;
        case URL_EMPTY_ERROR: errorDesc = @"Url cannot be empty"; break;
        case CONTRACTADDRESS_CODE_BOTH_NULL_ERROR: errorDesc = @"ContractAddress and code cannot be empty at the same time"; break;
        case INVALID_OPTTYPE_ERROR: errorDesc = @"OptType must be between 0 and 2"; break;
        case GET_ALLOWANCE_ERROR: errorDesc = @"Get allowance failed"; break;
        case GET_TOKEN_INFO_ERROR: errorDesc = @"Fail to get token info"; break;
        case SIGNATURE_EMPTY_ERROR: errorDesc = @"The signatures cannot be empty"; break;
        case CONNECTN_BLOCKCHAIN_ERROR: errorDesc = @"Connect blockchain failed"; break;
        case SYSTEM_ERROR: errorDesc = @"System error"; break;
        case REQUEST_NULL_ERROR: errorDesc = @"Request parameter cannot be null"; break;
        default: errorDesc = nil; break;
    }
    return errorDesc;
}
@end
