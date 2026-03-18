using System;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// provides database support for SectionA web control
	/// </summary>
	public class SectionA_DB
	{

		public static int InsertInitiative(string strName, 
                        string strIGBusinessAreaCode, string strIGIdentifierCode, 
                        int intIGVersionNumber,
						string strPrimarySponsoringArea, 
						string strOtherSponsoringAreas, 
			            string strBusinessSponsorName, int intBusinessSponsorID, 
			            string strBusinessInitiativeManager, int intBusinessInitiativeManagerID, 
                        string strRegion, int intRegionID,
			            string strGTOManagingBusinessArea, 
			            string strGTOInitiativeManager, int intGTOInitiativeManagerID, 
			            string strFunctionalDomain, int intFunctionalDomainID, 
			            string strSecondaryFunctionalDomain, int intSecondaryFunctionalDomainID,
                        string strTechnologyFunction, int intTechnologyFunctionID,
                        string strMajorApplicationName, string strMajorApplicationInvestmentStrategy, int intMajorApplicationID,
			            string strInitiativeBusinessDrivers, 
			            string strInitiativeScopeAndObjectives,
			            string strInitiativeBenefitCalculation, 
			            string strStrategicInitiativeInterfaces, 
			            string strSmartsourcingComponent,
			            string strArchitecturalCompliance,
                        string strArchitecturalComplianceType, int intArchitecturalComplianceTypeID)
		{
			int intInitiativeID;

			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdInsertInitiative = new SqlCommand();
			cmdInsertInitiative.Connection = dbConnection;

			cmdInsertInitiative.CommandType = CommandType.StoredProcedure;
			cmdInsertInitiative.CommandText = "spInsertInitiativeFull";

			cmdInsertInitiative.Parameters.Add("@ExternalUniqueIdentifier", Guid.NewGuid());

            cmdInsertInitiative.Parameters.Add("@Name", strName);
            
            cmdInsertInitiative.Parameters.Add("@IGBusinessAreaCode", strIGBusinessAreaCode);
            cmdInsertInitiative.Parameters.Add("@IGIdentifierCode", strIGIdentifierCode);
            cmdInsertInitiative.Parameters.Add("@IGVersionNumber", intIGVersionNumber);
            cmdInsertInitiative.Parameters.Add("@PrimarySponsoringArea", strPrimarySponsoringArea);
            cmdInsertInitiative.Parameters.Add("@OtherSponsoringAreas", strOtherSponsoringAreas);
            cmdInsertInitiative.Parameters.Add("@BusinessSponsorName", strBusinessSponsorName);
            cmdInsertInitiative.Parameters.Add("@BusinessSponsorID", intBusinessSponsorID);
            cmdInsertInitiative.Parameters.Add("@BusinessInitiativeManager", strBusinessInitiativeManager);
            cmdInsertInitiative.Parameters.Add("@BusinessInitiativeManagerID", intBusinessInitiativeManagerID);
            cmdInsertInitiative.Parameters.Add("@Region", strRegion);
            cmdInsertInitiative.Parameters.Add("@RegionID", intRegionID);
            cmdInsertInitiative.Parameters.Add("@GTOManagingBusinessArea", strGTOManagingBusinessArea);
            cmdInsertInitiative.Parameters.Add("@GTOInitiativeManager", strGTOInitiativeManager);
            cmdInsertInitiative.Parameters.Add("@GTOInitiativeManagerID", intGTOInitiativeManagerID);
            cmdInsertInitiative.Parameters.Add("@FunctionalDomain", strFunctionalDomain);
            cmdInsertInitiative.Parameters.Add("@FunctionalDomainID", intFunctionalDomainID);
            cmdInsertInitiative.Parameters.Add("@SecondaryFunctionalDomain", strSecondaryFunctionalDomain);
            cmdInsertInitiative.Parameters.Add("@SecondaryFunctionalDomainID", intSecondaryFunctionalDomainID);
            cmdInsertInitiative.Parameters.Add("@TechnologyFunction", strTechnologyFunction);
            cmdInsertInitiative.Parameters.Add("@TechnologyFunctionID", intTechnologyFunctionID);
            cmdInsertInitiative.Parameters.Add("@MajorApplicationName", strMajorApplicationName);
            cmdInsertInitiative.Parameters.Add("@MajorApplicationInvestmentStrategy", strMajorApplicationInvestmentStrategy);
            cmdInsertInitiative.Parameters.Add("@MajorApplicationID", intMajorApplicationID);
            cmdInsertInitiative.Parameters.Add("@InitiativeBusinessDrivers", strInitiativeBusinessDrivers);
            cmdInsertInitiative.Parameters.Add("@InitiativeScopeAndObjectives", strInitiativeScopeAndObjectives);
            cmdInsertInitiative.Parameters.Add("@InitiativeBenefitCalculation", strInitiativeBenefitCalculation);
            cmdInsertInitiative.Parameters.Add("@StrategicInitiativeInterfaces", strStrategicInitiativeInterfaces);
            cmdInsertInitiative.Parameters.Add("@SmartsourcingComponent", strSmartsourcingComponent);
            cmdInsertInitiative.Parameters.Add("@ArchitecturalCompliance", strArchitecturalCompliance);
            cmdInsertInitiative.Parameters.Add("@ArchitecturalComplianceType", strArchitecturalComplianceType);
            cmdInsertInitiative.Parameters.Add("@ArchitecturalComplianceTypeID", intArchitecturalComplianceTypeID);

			SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
			parmReturnValue.Direction = ParameterDirection.ReturnValue;

			cmdInsertInitiative.Parameters.Add(parmReturnValue);

			try
			{
				dbConnection.Open();
				cmdInsertInitiative.ExecuteNonQuery();	
			}
			catch(SqlException ex)
			{
				intInitiativeID = -1;
			}
			finally
			{
				dbConnection.Close();
			}

			if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
			{
				intInitiativeID = Convert.ToInt32(parmReturnValue.Value);
			}
			else
			{
				intInitiativeID = -1;
			}

			return intInitiativeID;
		}


		public static int UpdateInitiative(int intInitiativeID, 
                        string strName,
                        /* Rev 2.1.3, GMcF */
                        //string strPrimarySponsoringArea,
                        string strPrimarySBU, int intPrimarySBUID,
                        /* End of Rev 2.1.3 */
                        string strOtherSponsoringAreas,
                        string strBusinessSponsorName, int intBusinessSponsorID, 
                        string strBusinessInitiativeManager, int intBusinessInitiativeManagerID,
                        string strRegion, int intRegionID,
                        string strGTOManagingBusinessArea,
                        string strGTOInitiativeManager, int intGTOInitiativeManagerID,
                        string strFunctionalDomain, int intFunctionalDomainID,
                        string strSecondaryFunctionalDomain, int intSecondaryFunctionalDomainID,
                        string strTechnologyFunction, int intTechnologyFunctionID,
                        string strMajorApplicationName, string strMajorApplicationInvestmentStrategy, int intMajorApplicationID,                    
                        string strInitiativeBusinessDrivers,
                        string strInitiativeScopeAndObjectives,
                        string strInitiativeBenefitCalculation,
                        string strStrategicInitiativeInterfaces,
                        string strSmartsourcingComponent,
                        string strArchitecturalCompliance,
                        string strArchitecturalComplianceType, int intArchitecturalComplianceTypeID

                        ,
                        string strPPR_OverallStatus, int intPPR_OverallStatusID,
                        string strPPR_CostStatus, int intPPR_CostStatusID,
                        string strPPR_DeliverablesStatus, int intPPR_DeliverablesStatusID,
                        string strPPR_TimeStatus, int intPPR_TimeStatusID,
                        string strPPR_RisksStatus, int intPPR_RisksStatusID,
                        string strPPR_BenefitsStatus, int intPPR_BenefitsStatusID

                        ,
                        string strPPR_Comments

            )
		{
			int intRecordsAffected;

			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdUpdateInitiative = new SqlCommand();
			cmdUpdateInitiative.Connection = dbConnection;

			cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
			cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionA";

			cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

			cmdUpdateInitiative.Parameters.Add("@Name", strName);

            // Rev 2.1.3, GMcF
            //cmdUpdateInitiative.Parameters.Add("@PrimarySponsoringArea", strPrimarySponsoringArea);
            cmdUpdateInitiative.Parameters.Add("@PrimarySBU", strPrimarySBU);

            if ( intPrimarySBUID < 0 )
                cmdUpdateInitiative.Parameters.Add("@PrimarySBUID", null);
            else
                cmdUpdateInitiative.Parameters.Add("@PrimarySBUID", intPrimarySBUID);

            // End of Rev 2.1.3

            cmdUpdateInitiative.Parameters.Add("@OtherSponsoringAreas", strOtherSponsoringAreas);
            cmdUpdateInitiative.Parameters.Add("@BusinessSponsorName", strBusinessSponsorName);
            cmdUpdateInitiative.Parameters.Add("@BusinessSponsorID", intBusinessSponsorID);
            cmdUpdateInitiative.Parameters.Add("@BusinessInitiativeManager", strBusinessInitiativeManager);
            cmdUpdateInitiative.Parameters.Add("@BusinessInitiativeManagerID", intBusinessInitiativeManagerID);
            cmdUpdateInitiative.Parameters.Add("@Region", strRegion);
            cmdUpdateInitiative.Parameters.Add("@RegionID", intRegionID);
            cmdUpdateInitiative.Parameters.Add("@GTOManagingBusinessArea", strGTOManagingBusinessArea);
            cmdUpdateInitiative.Parameters.Add("@GTOInitiativeManager", strGTOInitiativeManager);
            cmdUpdateInitiative.Parameters.Add("@GTOInitiativeManagerID", intGTOInitiativeManagerID);
            cmdUpdateInitiative.Parameters.Add("@FunctionalDomain", strFunctionalDomain);
            cmdUpdateInitiative.Parameters.Add("@FunctionalDomainID", intFunctionalDomainID);
            cmdUpdateInitiative.Parameters.Add("@SecondaryFunctionalDomain", strSecondaryFunctionalDomain);
            cmdUpdateInitiative.Parameters.Add("@SecondaryFunctionalDomainID", intSecondaryFunctionalDomainID);
            cmdUpdateInitiative.Parameters.Add("@TechnologyFunction", strTechnologyFunction);
            cmdUpdateInitiative.Parameters.Add("@TechnologyFunctionID", intTechnologyFunctionID);
            cmdUpdateInitiative.Parameters.Add("@MajorApplicationName", strMajorApplicationName);
            cmdUpdateInitiative.Parameters.Add("@MajorApplicationInvestmentStrategy", strMajorApplicationInvestmentStrategy);
            cmdUpdateInitiative.Parameters.Add("@MajorApplicationID", intMajorApplicationID);
            cmdUpdateInitiative.Parameters.Add("@InitiativeBusinessDrivers", strInitiativeBusinessDrivers);
            cmdUpdateInitiative.Parameters.Add("@InitiativeScopeAndObjectives", strInitiativeScopeAndObjectives);
            cmdUpdateInitiative.Parameters.Add("@InitiativeBenefitCalculation", strInitiativeBenefitCalculation);
            cmdUpdateInitiative.Parameters.Add("@StrategicInitiativeInterfaces", strStrategicInitiativeInterfaces);
            cmdUpdateInitiative.Parameters.Add("@SmartsourcingComponent", strSmartsourcingComponent);
            cmdUpdateInitiative.Parameters.Add("@ArchitecturalCompliance", strArchitecturalCompliance);
            cmdUpdateInitiative.Parameters.Add("@ArchitecturalComplianceType", strArchitecturalComplianceType);
            cmdUpdateInitiative.Parameters.Add("@ArchitecturalComplianceTypeID", intArchitecturalComplianceTypeID);

            /* Rev 2.1.7, GMcF, 2008-05-19 */
            cmdUpdateInitiative.Parameters.Add("@PPR_OverallStatus", strPPR_OverallStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_OverallStatusID", intPPR_OverallStatusID);
            cmdUpdateInitiative.Parameters.Add("@PPR_CostStatus", strPPR_CostStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_CostStatusID", intPPR_CostStatusID);
            cmdUpdateInitiative.Parameters.Add("@PPR_DeliverablesStatus", strPPR_DeliverablesStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_DeliverablesStatusID", intPPR_DeliverablesStatusID);
            cmdUpdateInitiative.Parameters.Add("@PPR_TimeStatus", strPPR_TimeStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_TimeStatusID", intPPR_TimeStatusID);
            cmdUpdateInitiative.Parameters.Add("@PPR_RisksStatus", strPPR_RisksStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_RisksStatusID", intPPR_RisksStatusID);
            cmdUpdateInitiative.Parameters.Add("@PPR_BenefitsStatus", strPPR_BenefitsStatus);
            cmdUpdateInitiative.Parameters.Add("@PPR_BenefitsStatusID", intPPR_BenefitsStatusID);
            /* End of Rev 2.1.7 */

            // Added 2008-05-29, GMcF, for OTA 582 / Phase 2.1 UAT Feedback Item 13 - PPR Comments missing functionality
            cmdUpdateInitiative.Parameters.Add( "@PPR_Comments", strPPR_Comments );


			try
			{
				dbConnection.Open();
				intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();			
			}
			catch(SqlException ex)
			{
				intRecordsAffected = -1;
			}
			finally
			{
				dbConnection.Close();
			}

			return intRecordsAffected;
		}


		public static DataRow GetInitiativeDetails(int intInitiativeID)
		{
			DataRow drInitiative = null;

			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetInitiative = new SqlCommand();
			cmdGetInitiative.Connection = dbConnection;

			cmdGetInitiative.CommandType = CommandType.Text;

            // Rev 2.1.7
            //cmdGetInitiative.CommandText = "SELECT * FROM Initiative WHERE InitiativeID=@InitiativeID";		
            cmdGetInitiative.CommandText = "SELECT * FROM Initiative i left join InitiativeExtended iext on iext.InitiativeId = i.InitiativeId WHERE i.InitiativeID=@InitiativeID";
            // End of Rev2.1.7

			cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

			SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

			DataSet dsInitiative = new DataSet();

			try
			{
				daGetInitiative.Fill(dsInitiative, "Initiative");
			}
			catch(SqlException)
			{
				drInitiative = null;
			}
			
			if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
			{
				drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
			}

			return drInitiative;
		}

	}
}
