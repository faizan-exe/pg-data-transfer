--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: doctors; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA doctors;


--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clinicians_medicare; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.clinicians_medicare (
    npi integer,
    ind_pac_id character varying(100),
    "ind_enrl_Id" character varying(100),
    lst_nm character varying(100),
    frst_nm character varying(100),
    mid_nm character varying(100),
    suff character varying(100),
    gndr character(1),
    cred character varying(100),
    med_sch character varying(100),
    grd_yr integer,
    pri_spec character varying(100),
    sec_spec_1 character varying(1000),
    sec_spec_2 character varying(1000),
    sec_spec_3 character varying(1000),
    sec_spec_4 character varying(1000),
    sec_spec_all character varying(1000),
    telehlth character varying(100),
    org_nm character varying(100),
    org_pac_id character varying(100),
    num_org_mem integer,
    adr_ln_1 character varying(100),
    adr_ln_2 character varying(100),
    in_2_sprs character varying(100),
    cty character varying(100),
    state character varying(100),
    zip character varying(100),
    phn_numbr character varying(100),
    ind_assgn character(1),
    grp_assgn character(1),
    adrs_id character varying(100),
    filename character varying(150),
    created_at timestamp with time zone,
    full_name tsvector
);


--
-- Name: hospitals; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.hospitals (
    "ENROLLMENT_ID" character varying(50),
    "ENROLLMENT_STATE" character varying(50),
    "PROVIDER_TYPE_CODE" character varying(50),
    "PROVIDER_TYPE_TEXT" character varying(50),
    "NPI" integer,
    "MULTIPLE_NPI_FLAG" character(1),
    "CCN" character varying(50),
    "ASSOCIATE_ID" character varying(50),
    "ORGANIZATION_NAME" character varying(100),
    "DOING_BUSINESS_AS_NAME" character varying(100),
    "INCORPORATION_DATE" character varying(100),
    "INCORPORATION_STATE" character varying(2),
    "ORGANIZATION_TYPE_STRUCTURE" character varying(100),
    "ORGANIZATION_OTHER_TYPE_TEXT" character varying(100),
    "PROPRIETARY_NONPROFIT" character(1),
    "ADDRESS_LINE_1" character varying(100),
    "ADDRESS_LINE_2" character varying(100),
    "CITY" character varying(100),
    "STATE" character varying(2),
    "ZIP_CODE" character varying(10),
    "PRACTICE_LOCATION_TYPE" character varying(100),
    "LOCATION_OTHER_TYPE_TEXT" character varying(100),
    "SUBGROUP_GENERAL" character(1),
    "SUBGROUP_ACUTE_CARE" character(1),
    "SUBGROUP_ALCOHOL_DRUG" character(1),
    "SUBGROUP_CHILDRENS" character(1),
    "SUBGROUP_LONG_TERM" character(1),
    "SUBGROUP_PSYCHIATRIC" character(1),
    "SUBGROUP_REHABILITATION" character(1),
    "SUBGROUP_SHORT_TERM" character(1),
    "SUBGROUP_SWING_BED_APPROVED" character(1),
    "SUBGROUP_PSYCHIATRIC_UNIT" character(1),
    "SUBGROUP_REHABILITATION_UNIT" character(1),
    "SUBGROUP_SPECIALTY_HOSPITAL" character(1),
    "SUBGROUP_OTHER" character(1),
    "SUBGROUP_OTHER_TEXT" character varying(100),
    "REH_CONVERSION_FLAG" character(1),
    "REH_CONVERSION_DATE" character varying(50),
    "CAH_OR_HOSPITAL_CCN" character varying(50),
    created_at timestamp(6) without time zone
);


--
-- Name: medicare_facility_affiliations; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.medicare_facility_affiliations (
    "NPI" integer,
    "Ind_PAC_ID" character varying(100),
    lst_nm character varying(100),
    frst_nm character varying(100),
    mid_nm character varying(100),
    suff character varying(100),
    facility_type character varying(100),
    "Facility_Affiliations_Certification_Number" character varying(20),
    "Facility_Type_Certification_Number" integer,
    filename character varying(100),
    created_at timestamp without time zone,
    full_name tsvector
);


--
-- Name: clinicians_medicare_hospitals; Type: VIEW; Schema: doctors; Owner: -
--

CREATE VIEW doctors.clinicians_medicare_hospitals AS
 SELECT cm.npi,
    cm.ind_pac_id,
    cm."ind_enrl_Id",
    cm.lst_nm,
    cm.frst_nm,
    cm.mid_nm,
    cm.suff,
    cm.gndr,
    cm.cred,
    cm.med_sch,
    cm.grd_yr,
    cm.pri_spec,
    cm.sec_spec_1,
    cm.sec_spec_2,
    cm.sec_spec_3,
    cm.sec_spec_4,
    cm.sec_spec_all,
    cm.telehlth,
    cm.org_nm,
    cm.org_pac_id,
    cm.num_org_mem,
    cm.adr_ln_1,
    cm.adr_ln_2,
    cm.in_2_sprs,
    cm.cty,
    cm.state,
    cm.zip,
    cm.phn_numbr,
    cm.ind_assgn,
    cm.grp_assgn,
    cm.adrs_id,
    cm.filename,
    cm.created_at,
    h."ORGANIZATION_NAME" AS hospital_affiliation
   FROM ((doctors.clinicians_medicare cm
     LEFT JOIN doctors.medicare_facility_affiliations mfa ON (((cm.ind_pac_id)::text = (mfa."Ind_PAC_ID")::text)))
     LEFT JOIN doctors.hospitals h ON (((mfa."Facility_Affiliations_Certification_Number")::text = (h."CCN")::text)));


--
-- Name: conditions_procedure2; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.conditions_procedure2 (
    npi integer,
    string_agg text
);


--
-- Name: db_conditions; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.db_conditions (
    npi integer,
    conditions character varying(50000)
);


--
-- Name: db_procedures; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.db_procedures (
    npi integer,
    procedures character varying(50000)
);


--
-- Name: general_payments; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.general_payments (
    change_type character varying(20),
    covered_recipient_type character varying(50),
    teaching_hospital_ccn character varying(6),
    teaching_hospital_id integer,
    teaching_hospital_name character varying(100),
    covered_recipient_profile_id integer,
    covered_recipient_npi integer,
    covered_recipient_first_name character varying(20),
    covered_recipient_middle_name character varying(20),
    covered_recipient_last_name character varying(35),
    covered_recipient_name_suffix character varying(5),
    recipient_pri_business_street_add_line1 character varying(55),
    recipient_primary_business_street_add_line2 character varying(55),
    recipient_city character varying(40),
    recipient_state character(2),
    recipient_zip_code character varying(10),
    recipient_country character varying(100),
    recipient_province character varying(20),
    recipient_postal_code character varying(20),
    covered_recipient_primary_type_1 character varying(100),
    covered_recipient_primary_type_2 character varying(100),
    covered_recipient_primary_type_3 character varying(100),
    covered_recipient_primary_type_4 character varying(100),
    covered_recipient_primary_type_5 character varying(100),
    covered_recipient_primary_type_6 character varying(100),
    covered_recipient_specialty_1 character varying(300),
    covered_recipient_specialty_2 character varying(300),
    covered_recipient_specialty_3 character varying(300),
    covered_recipient_specialty_4 character varying(300),
    covered_recipient_specialty_5 character varying(300),
    covered_recipient_specialty_6 character varying(300),
    covered_recipient_license_state_code1 character(2),
    covered_recipient_license_state_code2 character(2),
    covered_recipient_license_state_code3 character(2),
    covered_recipient_license_state_code4 character(2),
    covered_recipient_license_state_code5 character(2),
    submitting_applicable_manufacturer_or_applicable_gpo_name character varying(100),
    applicable_manufacturer_or_applicable_gpo_making_payment_id character varying(12),
    applicable_manufacturer_or_applicable_gpo_making_payment_name character varying(100),
    applicable_manufacturer_or_applicable_gpo_making_payment_state character(2),
    applicable_manufacturer_or_applicable_gpo_making_payment_countr character varying(100),
    total_amount_of_payment_us double precision,
    date_of_payment date,
    number_of_payments_included_in_total_amount integer,
    form_of_payment_or_transfer_of_value character varying(100),
    nature_of_payment_or_transfer_of_value character varying(200),
    city_of_travel character varying(40),
    state_of_travel character(2),
    country_of_travel character varying(100),
    physician_ownership_indicator character(3),
    third_party_payment_recipient_indicator character varying(50),
    name_of_third_party_entity_receiving_payment_or_transfer_of_val character varying(50),
    charity_indicator character(3),
    third_party_equals_covered_recipient_indicator character(3),
    contextual_information character varying(500),
    delay_in_publication_indicator character(3),
    record_id integer,
    dispute_status_for_publication character(3),
    related_product_indicator character varying(100),
    covered_or_noncovered_indicator_1 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_1 character varying(100),
    product_category_or_therapeutic_area_1 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_1 character varying(500),
    associated_drug_or_biological_ndc_1 character varying(100),
    associated_device_or_medical_supply_pdi_1 character varying(100),
    covered_or_noncovered_indicator_2 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_2 character varying(100),
    product_category_or_therapeutic_area_2 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_2 character varying(500),
    associated_drug_or_biological_ndc_2 character varying(100),
    associated_device_or_medical_supply_pdi_2 character varying(100),
    covered_or_noncovered_indicator_3 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_3 character varying(100),
    product_category_or_therapeutic_area_3 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_3 character varying(500),
    associated_drug_or_biological_ndc_3 character varying(100),
    associated_device_or_medical_supply_pdi_3 character varying(100),
    covered_or_noncovered_indicator_4 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_4 character varying(100),
    product_category_or_therapeutic_area_4 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_4 character varying(500),
    associated_drug_or_biological_ndc_4 character varying(100),
    associated_device_or_medical_supply_pdi_4 character varying(100),
    covered_or_noncovered_indicator_5 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_5 character varying(100),
    product_category_or_therapeutic_area_5 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_5 character varying(500),
    associated_drug_or_biological_ndc_5 character varying(100),
    associated_device_or_medical_supply_pdi_5 character varying(100),
    program_year character(4),
    payment_publication_date date
);


--
-- Name: malpractice; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.malpractice (
    title character varying,
    "Filed Date" character varying(16),
    "Updated Date" character varying(32),
    status character varying(8),
    "Nature of Suit" character varying(128),
    topic character varying(1),
    "Area Of Law" character varying(1),
    "Full Case Name" character varying(128),
    "Short Case Name" character varying(128),
    "Docket Number" character varying(32),
    "Court Name" character varying(64),
    "Court State" character varying(16),
    injury character varying(1),
    "Type of Injury" character varying(1),
    outcome character varying(1),
    "Case Resolution" character varying(1),
    award integer,
    disbursement character varying(1),
    judge character varying(128),
    plaintiff character varying(128),
    defendant character varying(512),
    "Plaintiff Attorney" character varying(64),
    "Defendant Attorney" character varying(1024),
    "Fact Summary" character varying(1),
    "Index Term 1" character varying(32),
    "Index Term 2" character varying(32),
    "Index Term 3" character varying(128),
    "Index Term 4" character varying(32),
    "Defendant /physician's name " character varying(32),
    "Work address affilitated to their file" character varying(128),
    "License Number" character varying(64)
);


--
-- Name: medications; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.medications (
    prscrbr_npi integer,
    prscrbr_last_org_name character varying(100),
    prscrbr_first_name character varying(100),
    prscrbr_city character varying(100),
    prscrbr_state_abrvtn character varying(100),
    prscrbr_state_fips character varying(10),
    prscrbr_type character varying(100),
    prscrbr_type_src character(1),
    brnd_name character varying(100),
    gnrc_name character varying(100),
    tot_clms integer,
    tot_30day_fills real,
    tot_day_suply integer,
    tot_drug_cst real,
    tot_benes character varying(100),
    ge65_sprsn_flag character varying(100),
    ge65_tot_clms character varying(100),
    ge65_tot_30day_fills character varying(100),
    ge65_tot_drug_cst character varying(100),
    ge65_tot_day_suply character varying(100),
    ge65_bene_sprsn_flag character varying(100),
    ge65_tot_benes character varying(100),
    filename character varying(200),
    created_at timestamp with time zone
);


--
-- Name: npidata; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.npidata (
    npi integer,
    entity_type_code character varying(100),
    replacement_npi character varying(100),
    employer_identification_number_ein character varying(100),
    provider_organization_name_legal_business_name character varying(100),
    provider_last_name_legal_name character varying(100),
    provider_first_name character varying(100),
    provider_middle_name character varying(100),
    provider_name_prefix_text character varying(100),
    provider_name_suffix_text character varying(100),
    provider_credential_text character varying(100),
    provider_other_organization_name character varying(100),
    provider_other_organization_name_type_code character varying(100),
    provider_other_last_name character varying(100),
    provider_other_first_name character varying(100),
    provider_other_middle_name character varying(100),
    provider_other_name_prefix_text character varying(100),
    provider_other_name_suffix_text character varying(100),
    provider_other_credential_text character varying(100),
    provider_other_last_name_type_code character varying(100),
    provider_first_line_business_mailing_address character varying(100),
    provider_second_line_business_mailing_address character varying(100),
    provider_business_mailing_address_city_name character varying(100),
    provider_business_mailing_address_state_name character varying(100),
    provider_business_mailing_address_postal_code character varying(100),
    provider_business_mailing_address_country_code_if_outside_u_s character varying(100),
    provider_business_mailing_address_telephone_number character varying(100),
    provider_business_mailing_address_fax_number character varying(100),
    provider_first_line_business_practice_location_address character varying(100),
    provider_second_line_business_practice_location_address character varying(100),
    provider_business_practice_location_address_city_name character varying(100),
    provider_business_practice_location_address_state_name character varying(100),
    provider_business_practice_location_address_postal_code character varying(100),
    provider_business_practice_location_address_country_code_if_out character varying(100),
    provider_business_practice_location_address_telephone_number character varying(100),
    provider_business_practice_location_address_fax_number character varying(100),
    provider_enumeration_date character varying(100),
    last_update_date character varying(100),
    npi_deactivation_reason_code character varying(100),
    npi_deactivation_date character varying(100),
    npi_reactivation_date character varying(100),
    provider_gender_code character varying(100),
    authorized_official_last_name character varying(100),
    authorized_official_first_name character varying(100),
    authorized_official_middle_name character varying(100),
    authorized_official_title_or_position character varying(100),
    authorized_official_telephone_number character varying(100),
    healthcare_provider_taxonomy_code_1 character varying(100),
    provider_license_number_1 character varying(100),
    provider_license_number_state_code_1 character varying(100),
    healthcare_provider_primary_taxonomy_switch_1 character varying(100),
    healthcare_provider_taxonomy_code_2 character varying(100),
    provider_license_number_2 character varying(100),
    provider_license_number_state_code_2 character varying(100),
    healthcare_provider_primary_taxonomy_switch_2 character varying(100),
    healthcare_provider_taxonomy_code_3 character varying(100),
    provider_license_number_3 character varying(100),
    provider_license_number_state_code_3 character varying(100),
    healthcare_provider_primary_taxonomy_switch_3 character varying(100),
    healthcare_provider_taxonomy_code_4 character varying(100),
    provider_license_number_4 character varying(100),
    provider_license_number_state_code_4 character varying(100),
    healthcare_provider_primary_taxonomy_switch_4 character varying(100),
    healthcare_provider_taxonomy_code_5 character varying(100),
    provider_license_number_5 character varying(100),
    provider_license_number_state_code_5 character varying(100),
    healthcare_provider_primary_taxonomy_switch_5 character varying(100),
    healthcare_provider_taxonomy_code_6 character varying(100),
    provider_license_number_6 character varying(100),
    provider_license_number_state_code_6 character varying(100),
    healthcare_provider_primary_taxonomy_switch_6 character varying(100),
    healthcare_provider_taxonomy_code_7 character varying(100),
    provider_license_number_7 character varying(100),
    provider_license_number_state_code_7 character varying(100),
    healthcare_provider_primary_taxonomy_switch_7 character varying(100),
    healthcare_provider_taxonomy_code_8 character varying(100),
    provider_license_number_8 character varying(100),
    provider_license_number_state_code_8 character varying(100),
    healthcare_provider_primary_taxonomy_switch_8 character varying(100),
    healthcare_provider_taxonomy_code_9 character varying(100),
    provider_license_number_9 character varying(100),
    provider_license_number_state_code_9 character varying(100),
    healthcare_provider_primary_taxonomy_switch_9 character varying(100),
    healthcare_provider_taxonomy_code_10 character varying(100),
    provider_license_number_10 character varying(100),
    provider_license_number_state_code_10 character varying(100),
    healthcare_provider_primary_taxonomy_switch_10 character varying(100),
    healthcare_provider_taxonomy_code_11 character varying(100),
    provider_license_number_11 character varying(100),
    provider_license_number_state_code_11 character varying(100),
    healthcare_provider_primary_taxonomy_switch_11 character varying(100),
    healthcare_provider_taxonomy_code_12 character varying(100),
    provider_license_number_12 character varying(100),
    provider_license_number_state_code_12 character varying(100),
    healthcare_provider_primary_taxonomy_switch_12 character varying(100),
    healthcare_provider_taxonomy_code_13 character varying(100),
    provider_license_number_13 character varying(100),
    provider_license_number_state_code_13 character varying(100),
    healthcare_provider_primary_taxonomy_switch_13 character varying(100),
    healthcare_provider_taxonomy_code_14 character varying(100),
    provider_license_number_14 character varying(100),
    provider_license_number_state_code_14 character varying(100),
    healthcare_provider_primary_taxonomy_switch_14 character varying(100),
    healthcare_provider_taxonomy_code_15 character varying(100),
    provider_license_number_15 character varying(100),
    provider_license_number_state_code_15 character varying(100),
    healthcare_provider_primary_taxonomy_switch_15 character varying(100),
    other_provider_identifier_1 character varying(100),
    other_provider_identifier_type_code_1 character varying(100),
    other_provider_identifier_state_1 character varying(100),
    other_provider_identifier_issuer_1 character varying(100),
    other_provider_identifier_2 character varying(100),
    other_provider_identifier_type_code_2 character varying(100),
    other_provider_identifier_state_2 character varying(100),
    other_provider_identifier_issuer_2 character varying(100),
    other_provider_identifier_3 character varying(100),
    other_provider_identifier_type_code_3 character varying(100),
    other_provider_identifier_state_3 character varying(100),
    other_provider_identifier_issuer_3 character varying(100),
    other_provider_identifier_4 character varying(100),
    other_provider_identifier_type_code_4 character varying(100),
    other_provider_identifier_state_4 character varying(100),
    other_provider_identifier_issuer_4 character varying(100),
    other_provider_identifier_5 character varying(100),
    other_provider_identifier_type_code_5 character varying(100),
    other_provider_identifier_state_5 character varying(100),
    other_provider_identifier_issuer_5 character varying(100),
    other_provider_identifier_6 character varying(100),
    other_provider_identifier_type_code_6 character varying(100),
    other_provider_identifier_state_6 character varying(100),
    other_provider_identifier_issuer_6 character varying(100),
    other_provider_identifier_7 character varying(100),
    other_provider_identifier_type_code_7 character varying(100),
    other_provider_identifier_state_7 character varying(100),
    other_provider_identifier_issuer_7 character varying(100),
    other_provider_identifier_8 character varying(100),
    other_provider_identifier_type_code_8 character varying(100),
    other_provider_identifier_state_8 character varying(100),
    other_provider_identifier_issuer_8 character varying(100),
    other_provider_identifier_9 character varying(100),
    other_provider_identifier_type_code_9 character varying(100),
    other_provider_identifier_state_9 character varying(100),
    other_provider_identifier_issuer_9 character varying(100),
    other_provider_identifier_10 character varying(100),
    other_provider_identifier_type_code_10 character varying(100),
    other_provider_identifier_state_10 character varying(100),
    other_provider_identifier_issuer_10 character varying(100),
    other_provider_identifier_11 character varying(100),
    other_provider_identifier_type_code_11 character varying(100),
    other_provider_identifier_state_11 character varying(100),
    other_provider_identifier_issuer_11 character varying(100),
    other_provider_identifier_12 character varying(100),
    other_provider_identifier_type_code_12 character varying(100),
    other_provider_identifier_state_12 character varying(100),
    other_provider_identifier_issuer_12 character varying(100),
    other_provider_identifier_13 character varying(100),
    other_provider_identifier_type_code_13 character varying(100),
    other_provider_identifier_state_13 character varying(100),
    other_provider_identifier_issuer_13 character varying(100),
    other_provider_identifier_14 character varying(100),
    other_provider_identifier_type_code_14 character varying(100),
    other_provider_identifier_state_14 character varying(100),
    other_provider_identifier_issuer_14 character varying(100),
    other_provider_identifier_15 character varying(100),
    other_provider_identifier_type_code_15 character varying(100),
    other_provider_identifier_state_15 character varying(100),
    other_provider_identifier_issuer_15 character varying(100),
    other_provider_identifier_16 character varying(100),
    other_provider_identifier_type_code_16 character varying(100),
    other_provider_identifier_state_16 character varying(100),
    other_provider_identifier_issuer_16 character varying(100),
    other_provider_identifier_17 character varying(100),
    other_provider_identifier_type_code_17 character varying(100),
    other_provider_identifier_state_17 character varying(100),
    other_provider_identifier_issuer_17 character varying(100),
    other_provider_identifier_18 character varying(100),
    other_provider_identifier_type_code_18 character varying(100),
    other_provider_identifier_state_18 character varying(100),
    other_provider_identifier_issuer_18 character varying(100),
    other_provider_identifier_19 character varying(100),
    other_provider_identifier_type_code_19 character varying(100),
    other_provider_identifier_state_19 character varying(100),
    other_provider_identifier_issuer_19 character varying(100),
    other_provider_identifier_20 character varying(100),
    other_provider_identifier_type_code_20 character varying(100),
    other_provider_identifier_state_20 character varying(100),
    other_provider_identifier_issuer_20 character varying(100),
    other_provider_identifier_21 character varying(100),
    other_provider_identifier_type_code_21 character varying(100),
    other_provider_identifier_state_21 character varying(100),
    other_provider_identifier_issuer_21 character varying(100),
    other_provider_identifier_22 character varying(100),
    other_provider_identifier_type_code_22 character varying(100),
    other_provider_identifier_state_22 character varying(100),
    other_provider_identifier_issuer_22 character varying(100),
    other_provider_identifier_23 character varying(100),
    other_provider_identifier_type_code_23 character varying(100),
    other_provider_identifier_state_23 character varying(100),
    other_provider_identifier_issuer_23 character varying(100),
    other_provider_identifier_24 character varying(100),
    other_provider_identifier_type_code_24 character varying(100),
    other_provider_identifier_state_24 character varying(100),
    other_provider_identifier_issuer_24 character varying(100),
    other_provider_identifier_25 character varying(100),
    other_provider_identifier_type_code_25 character varying(100),
    other_provider_identifier_state_25 character varying(100),
    other_provider_identifier_issuer_25 character varying(100),
    other_provider_identifier_26 character varying(100),
    other_provider_identifier_type_code_26 character varying(100),
    other_provider_identifier_state_26 character varying(100),
    other_provider_identifier_issuer_26 character varying(100),
    other_provider_identifier_27 character varying(100),
    other_provider_identifier_type_code_27 character varying(100),
    other_provider_identifier_state_27 character varying(100),
    other_provider_identifier_issuer_27 character varying(100),
    other_provider_identifier_28 character varying(100),
    other_provider_identifier_type_code_28 character varying(100),
    other_provider_identifier_state_28 character varying(100),
    other_provider_identifier_issuer_28 character varying(100),
    other_provider_identifier_29 character varying(100),
    other_provider_identifier_type_code_29 character varying(100),
    other_provider_identifier_state_29 character varying(100),
    other_provider_identifier_issuer_29 character varying(100),
    other_provider_identifier_30 character varying(100),
    other_provider_identifier_type_code_30 character varying(100),
    other_provider_identifier_state_30 character varying(100),
    other_provider_identifier_issuer_30 character varying(100),
    other_provider_identifier_31 character varying(100),
    other_provider_identifier_type_code_31 character varying(100),
    other_provider_identifier_state_31 character varying(100),
    other_provider_identifier_issuer_31 character varying(100),
    other_provider_identifier_32 character varying(100),
    other_provider_identifier_type_code_32 character varying(100),
    other_provider_identifier_state_32 character varying(100),
    other_provider_identifier_issuer_32 character varying(100),
    other_provider_identifier_33 character varying(100),
    other_provider_identifier_type_code_33 character varying(100),
    other_provider_identifier_state_33 character varying(100),
    other_provider_identifier_issuer_33 character varying(100),
    other_provider_identifier_34 character varying(100),
    other_provider_identifier_type_code_34 character varying(100),
    other_provider_identifier_state_34 character varying(100),
    other_provider_identifier_issuer_34 character varying(100),
    other_provider_identifier_35 character varying(100),
    other_provider_identifier_type_code_35 character varying(100),
    other_provider_identifier_state_35 character varying(100),
    other_provider_identifier_issuer_35 character varying(100),
    other_provider_identifier_36 character varying(100),
    other_provider_identifier_type_code_36 character varying(100),
    other_provider_identifier_state_36 character varying(100),
    other_provider_identifier_issuer_36 character varying(100),
    other_provider_identifier_37 character varying(100),
    other_provider_identifier_type_code_37 character varying(100),
    other_provider_identifier_state_37 character varying(100),
    other_provider_identifier_issuer_37 character varying(100),
    other_provider_identifier_38 character varying(100),
    other_provider_identifier_type_code_38 character varying(100),
    other_provider_identifier_state_38 character varying(100),
    other_provider_identifier_issuer_38 character varying(100),
    other_provider_identifier_39 character varying(100),
    other_provider_identifier_type_code_39 character varying(100),
    other_provider_identifier_state_39 character varying(100),
    other_provider_identifier_issuer_39 character varying(100),
    other_provider_identifier_40 character varying(100),
    other_provider_identifier_type_code_40 character varying(100),
    other_provider_identifier_state_40 character varying(100),
    other_provider_identifier_issuer_40 character varying(100),
    other_provider_identifier_41 character varying(100),
    other_provider_identifier_type_code_41 character varying(100),
    other_provider_identifier_state_41 character varying(100),
    other_provider_identifier_issuer_41 character varying(100),
    other_provider_identifier_42 character varying(100),
    other_provider_identifier_type_code_42 character varying(100),
    other_provider_identifier_state_42 character varying(100),
    other_provider_identifier_issuer_42 character varying(100),
    other_provider_identifier_43 character varying(100),
    other_provider_identifier_type_code_43 character varying(100),
    other_provider_identifier_state_43 character varying(100),
    other_provider_identifier_issuer_43 character varying(100),
    other_provider_identifier_44 character varying(100),
    other_provider_identifier_type_code_44 character varying(100),
    other_provider_identifier_state_44 character varying(100),
    other_provider_identifier_issuer_44 character varying(100),
    other_provider_identifier_45 character varying(100),
    other_provider_identifier_type_code_45 character varying(100),
    other_provider_identifier_state_45 character varying(100),
    other_provider_identifier_issuer_45 character varying(100),
    other_provider_identifier_46 character varying(100),
    other_provider_identifier_type_code_46 character varying(100),
    other_provider_identifier_state_46 character varying(100),
    other_provider_identifier_issuer_46 character varying(100),
    other_provider_identifier_47 character varying(100),
    other_provider_identifier_type_code_47 character varying(100),
    other_provider_identifier_state_47 character varying(100),
    other_provider_identifier_issuer_47 character varying(100),
    other_provider_identifier_48 character varying(100),
    other_provider_identifier_type_code_48 character varying(100),
    other_provider_identifier_state_48 character varying(100),
    other_provider_identifier_issuer_48 character varying(100),
    other_provider_identifier_49 character varying(100),
    other_provider_identifier_type_code_49 character varying(100),
    other_provider_identifier_state_49 character varying(100),
    other_provider_identifier_issuer_49 character varying(100),
    other_provider_identifier_50 character varying(100),
    other_provider_identifier_type_code_50 character varying(100),
    other_provider_identifier_state_50 character varying(100),
    other_provider_identifier_issuer_50 character varying(100),
    is_sole_proprietor character varying(100),
    is_organization_subpart character varying(100),
    parent_organization_lbn character varying(100),
    parent_organization_tin character varying(100),
    authorized_official_name_prefix_text character varying(100),
    authorized_official_name_suffix_text character varying(100),
    authorized_official_credential_text character varying(100),
    healthcare_provider_taxonomy_group_1 character varying(100),
    healthcare_provider_taxonomy_group_2 character varying(100),
    healthcare_provider_taxonomy_group_3 character varying(100),
    healthcare_provider_taxonomy_group_4 character varying(100),
    healthcare_provider_taxonomy_group_5 character varying(100),
    healthcare_provider_taxonomy_group_6 character varying(100),
    healthcare_provider_taxonomy_group_7 character varying(100),
    healthcare_provider_taxonomy_group_8 character varying(100),
    healthcare_provider_taxonomy_group_9 character varying(100),
    healthcare_provider_taxonomy_group_10 character varying(100),
    healthcare_provider_taxonomy_group_11 character varying(100),
    healthcare_provider_taxonomy_group_12 character varying(100),
    healthcare_provider_taxonomy_group_13 character varying(100),
    healthcare_provider_taxonomy_group_14 character varying(100),
    healthcare_provider_taxonomy_group_15 character varying(100),
    certification_date character varying(100),
    filename character varying,
    created_at timestamp with time zone,
    names_with_index tsvector,
    full_name character varying,
    grad_yr integer,
    telehealth character varying,
    mailing_long double precision,
    mailing_lat double precision,
    mailing_location_point public.geometry,
    practice_zip_short integer,
    practice_long double precision,
    practice_lat double precision,
    org_name_search tsvector,
    verified boolean DEFAULT false NOT NULL
);


--
-- Name: npidata_complete_lat_long; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.npidata_complete_lat_long (
    npi integer,
    entity_type_code character varying(100),
    replacement_npi character varying(100),
    employer_identification_number_ein character varying(100),
    provider_organization_name_legal_business_name character varying(100),
    provider_last_name_legal_name character varying(100),
    provider_first_name character varying(100),
    provider_middle_name character varying(100),
    provider_name_prefix_text character varying(100),
    provider_name_suffix_text character varying(100),
    provider_credential_text character varying(100),
    provider_other_organization_name character varying(100),
    provider_other_organization_name_type_code character varying(100),
    provider_other_last_name character varying(100),
    provider_other_first_name character varying(100),
    provider_other_middle_name character varying(100),
    provider_other_name_prefix_text character varying(100),
    provider_other_name_suffix_text character varying(100),
    provider_other_credential_text character varying(100),
    provider_other_last_name_type_code character varying(100),
    provider_first_line_business_mailing_address character varying(100),
    provider_second_line_business_mailing_address character varying(100),
    provider_business_mailing_address_city_name character varying(100),
    provider_business_mailing_address_state_name character varying(100),
    provider_business_mailing_address_postal_code character varying(100),
    provider_business_mailing_address_country_code_if_outside_u_s character varying(100),
    provider_business_mailing_address_telephone_number character varying(100),
    provider_business_mailing_address_fax_number character varying(100),
    provider_first_line_business_practice_location_address character varying(100),
    provider_second_line_business_practice_location_address character varying(100),
    provider_business_practice_location_address_city_name character varying(100),
    provider_business_practice_location_address_state_name character varying(100),
    provider_business_practice_location_address_postal_code character varying(100),
    provider_business_practice_location_address_country_code_if_out character varying(100),
    provider_business_practice_location_address_telephone_number character varying(100),
    provider_business_practice_location_address_fax_number character varying(100),
    provider_enumeration_date character varying(100),
    last_update_date character varying(100),
    npi_deactivation_reason_code character varying(100),
    npi_deactivation_date character varying(100),
    npi_reactivation_date character varying(100),
    provider_gender_code character varying(100),
    authorized_official_last_name character varying(100),
    authorized_official_first_name character varying(100),
    authorized_official_middle_name character varying(100),
    authorized_official_title_or_position character varying(100),
    authorized_official_telephone_number character varying(100),
    healthcare_provider_taxonomy_code_1 character varying(100),
    provider_license_number_1 character varying(100),
    provider_license_number_state_code_1 character varying(100),
    healthcare_provider_primary_taxonomy_switch_1 character varying(100),
    healthcare_provider_taxonomy_code_2 character varying(100),
    provider_license_number_2 character varying(100),
    provider_license_number_state_code_2 character varying(100),
    healthcare_provider_primary_taxonomy_switch_2 character varying(100),
    healthcare_provider_taxonomy_code_3 character varying(100),
    provider_license_number_3 character varying(100),
    provider_license_number_state_code_3 character varying(100),
    healthcare_provider_primary_taxonomy_switch_3 character varying(100),
    healthcare_provider_taxonomy_code_4 character varying(100),
    provider_license_number_4 character varying(100),
    provider_license_number_state_code_4 character varying(100),
    healthcare_provider_primary_taxonomy_switch_4 character varying(100),
    healthcare_provider_taxonomy_code_5 character varying(100),
    provider_license_number_5 character varying(100),
    provider_license_number_state_code_5 character varying(100),
    healthcare_provider_primary_taxonomy_switch_5 character varying(100),
    healthcare_provider_taxonomy_code_6 character varying(100),
    provider_license_number_6 character varying(100),
    provider_license_number_state_code_6 character varying(100),
    healthcare_provider_primary_taxonomy_switch_6 character varying(100),
    healthcare_provider_taxonomy_code_7 character varying(100),
    provider_license_number_7 character varying(100),
    provider_license_number_state_code_7 character varying(100),
    healthcare_provider_primary_taxonomy_switch_7 character varying(100),
    healthcare_provider_taxonomy_code_8 character varying(100),
    provider_license_number_8 character varying(100),
    provider_license_number_state_code_8 character varying(100),
    healthcare_provider_primary_taxonomy_switch_8 character varying(100),
    healthcare_provider_taxonomy_code_9 character varying(100),
    provider_license_number_9 character varying(100),
    provider_license_number_state_code_9 character varying(100),
    healthcare_provider_primary_taxonomy_switch_9 character varying(100),
    healthcare_provider_taxonomy_code_10 character varying(100),
    provider_license_number_10 character varying(100),
    provider_license_number_state_code_10 character varying(100),
    healthcare_provider_primary_taxonomy_switch_10 character varying(100),
    healthcare_provider_taxonomy_code_11 character varying(100),
    provider_license_number_11 character varying(100),
    provider_license_number_state_code_11 character varying(100),
    healthcare_provider_primary_taxonomy_switch_11 character varying(100),
    healthcare_provider_taxonomy_code_12 character varying(100),
    provider_license_number_12 character varying(100),
    provider_license_number_state_code_12 character varying(100),
    healthcare_provider_primary_taxonomy_switch_12 character varying(100),
    healthcare_provider_taxonomy_code_13 character varying(100),
    provider_license_number_13 character varying(100),
    provider_license_number_state_code_13 character varying(100),
    healthcare_provider_primary_taxonomy_switch_13 character varying(100),
    healthcare_provider_taxonomy_code_14 character varying(100),
    provider_license_number_14 character varying(100),
    provider_license_number_state_code_14 character varying(100),
    healthcare_provider_primary_taxonomy_switch_14 character varying(100),
    healthcare_provider_taxonomy_code_15 character varying(100),
    provider_license_number_15 character varying(100),
    provider_license_number_state_code_15 character varying(100),
    healthcare_provider_primary_taxonomy_switch_15 character varying(100),
    other_provider_identifier_1 character varying(100),
    other_provider_identifier_type_code_1 character varying(100),
    other_provider_identifier_state_1 character varying(100),
    other_provider_identifier_issuer_1 character varying(100),
    other_provider_identifier_2 character varying(100),
    other_provider_identifier_type_code_2 character varying(100),
    other_provider_identifier_state_2 character varying(100),
    other_provider_identifier_issuer_2 character varying(100),
    other_provider_identifier_3 character varying(100),
    other_provider_identifier_type_code_3 character varying(100),
    other_provider_identifier_state_3 character varying(100),
    other_provider_identifier_issuer_3 character varying(100),
    other_provider_identifier_4 character varying(100),
    other_provider_identifier_type_code_4 character varying(100),
    other_provider_identifier_state_4 character varying(100),
    other_provider_identifier_issuer_4 character varying(100),
    other_provider_identifier_5 character varying(100),
    other_provider_identifier_type_code_5 character varying(100),
    other_provider_identifier_state_5 character varying(100),
    other_provider_identifier_issuer_5 character varying(100),
    other_provider_identifier_6 character varying(100),
    other_provider_identifier_type_code_6 character varying(100),
    other_provider_identifier_state_6 character varying(100),
    other_provider_identifier_issuer_6 character varying(100),
    other_provider_identifier_7 character varying(100),
    other_provider_identifier_type_code_7 character varying(100),
    other_provider_identifier_state_7 character varying(100),
    other_provider_identifier_issuer_7 character varying(100),
    other_provider_identifier_8 character varying(100),
    other_provider_identifier_type_code_8 character varying(100),
    other_provider_identifier_state_8 character varying(100),
    other_provider_identifier_issuer_8 character varying(100),
    other_provider_identifier_9 character varying(100),
    other_provider_identifier_type_code_9 character varying(100),
    other_provider_identifier_state_9 character varying(100),
    other_provider_identifier_issuer_9 character varying(100),
    other_provider_identifier_10 character varying(100),
    other_provider_identifier_type_code_10 character varying(100),
    other_provider_identifier_state_10 character varying(100),
    other_provider_identifier_issuer_10 character varying(100),
    other_provider_identifier_11 character varying(100),
    other_provider_identifier_type_code_11 character varying(100),
    other_provider_identifier_state_11 character varying(100),
    other_provider_identifier_issuer_11 character varying(100),
    other_provider_identifier_12 character varying(100),
    other_provider_identifier_type_code_12 character varying(100),
    other_provider_identifier_state_12 character varying(100),
    other_provider_identifier_issuer_12 character varying(100),
    other_provider_identifier_13 character varying(100),
    other_provider_identifier_type_code_13 character varying(100),
    other_provider_identifier_state_13 character varying(100),
    other_provider_identifier_issuer_13 character varying(100),
    other_provider_identifier_14 character varying(100),
    other_provider_identifier_type_code_14 character varying(100),
    other_provider_identifier_state_14 character varying(100),
    other_provider_identifier_issuer_14 character varying(100),
    other_provider_identifier_15 character varying(100),
    other_provider_identifier_type_code_15 character varying(100),
    other_provider_identifier_state_15 character varying(100),
    other_provider_identifier_issuer_15 character varying(100),
    other_provider_identifier_16 character varying(100),
    other_provider_identifier_type_code_16 character varying(100),
    other_provider_identifier_state_16 character varying(100),
    other_provider_identifier_issuer_16 character varying(100),
    other_provider_identifier_17 character varying(100),
    other_provider_identifier_type_code_17 character varying(100),
    other_provider_identifier_state_17 character varying(100),
    other_provider_identifier_issuer_17 character varying(100),
    other_provider_identifier_18 character varying(100),
    other_provider_identifier_type_code_18 character varying(100),
    other_provider_identifier_state_18 character varying(100),
    other_provider_identifier_issuer_18 character varying(100),
    other_provider_identifier_19 character varying(100),
    other_provider_identifier_type_code_19 character varying(100),
    other_provider_identifier_state_19 character varying(100),
    other_provider_identifier_issuer_19 character varying(100),
    other_provider_identifier_20 character varying(100),
    other_provider_identifier_type_code_20 character varying(100),
    other_provider_identifier_state_20 character varying(100),
    other_provider_identifier_issuer_20 character varying(100),
    other_provider_identifier_21 character varying(100),
    other_provider_identifier_type_code_21 character varying(100),
    other_provider_identifier_state_21 character varying(100),
    other_provider_identifier_issuer_21 character varying(100),
    other_provider_identifier_22 character varying(100),
    other_provider_identifier_type_code_22 character varying(100),
    other_provider_identifier_state_22 character varying(100),
    other_provider_identifier_issuer_22 character varying(100),
    other_provider_identifier_23 character varying(100),
    other_provider_identifier_type_code_23 character varying(100),
    other_provider_identifier_state_23 character varying(100),
    other_provider_identifier_issuer_23 character varying(100),
    other_provider_identifier_24 character varying(100),
    other_provider_identifier_type_code_24 character varying(100),
    other_provider_identifier_state_24 character varying(100),
    other_provider_identifier_issuer_24 character varying(100),
    other_provider_identifier_25 character varying(100),
    other_provider_identifier_type_code_25 character varying(100),
    other_provider_identifier_state_25 character varying(100),
    other_provider_identifier_issuer_25 character varying(100),
    other_provider_identifier_26 character varying(100),
    other_provider_identifier_type_code_26 character varying(100),
    other_provider_identifier_state_26 character varying(100),
    other_provider_identifier_issuer_26 character varying(100),
    other_provider_identifier_27 character varying(100),
    other_provider_identifier_type_code_27 character varying(100),
    other_provider_identifier_state_27 character varying(100),
    other_provider_identifier_issuer_27 character varying(100),
    other_provider_identifier_28 character varying(100),
    other_provider_identifier_type_code_28 character varying(100),
    other_provider_identifier_state_28 character varying(100),
    other_provider_identifier_issuer_28 character varying(100),
    other_provider_identifier_29 character varying(100),
    other_provider_identifier_type_code_29 character varying(100),
    other_provider_identifier_state_29 character varying(100),
    other_provider_identifier_issuer_29 character varying(100),
    other_provider_identifier_30 character varying(100),
    other_provider_identifier_type_code_30 character varying(100),
    other_provider_identifier_state_30 character varying(100),
    other_provider_identifier_issuer_30 character varying(100),
    other_provider_identifier_31 character varying(100),
    other_provider_identifier_type_code_31 character varying(100),
    other_provider_identifier_state_31 character varying(100),
    other_provider_identifier_issuer_31 character varying(100),
    other_provider_identifier_32 character varying(100),
    other_provider_identifier_type_code_32 character varying(100),
    other_provider_identifier_state_32 character varying(100),
    other_provider_identifier_issuer_32 character varying(100),
    other_provider_identifier_33 character varying(100),
    other_provider_identifier_type_code_33 character varying(100),
    other_provider_identifier_state_33 character varying(100),
    other_provider_identifier_issuer_33 character varying(100),
    other_provider_identifier_34 character varying(100),
    other_provider_identifier_type_code_34 character varying(100),
    other_provider_identifier_state_34 character varying(100),
    other_provider_identifier_issuer_34 character varying(100),
    other_provider_identifier_35 character varying(100),
    other_provider_identifier_type_code_35 character varying(100),
    other_provider_identifier_state_35 character varying(100),
    other_provider_identifier_issuer_35 character varying(100),
    other_provider_identifier_36 character varying(100),
    other_provider_identifier_type_code_36 character varying(100),
    other_provider_identifier_state_36 character varying(100),
    other_provider_identifier_issuer_36 character varying(100),
    other_provider_identifier_37 character varying(100),
    other_provider_identifier_type_code_37 character varying(100),
    other_provider_identifier_state_37 character varying(100),
    other_provider_identifier_issuer_37 character varying(100),
    other_provider_identifier_38 character varying(100),
    other_provider_identifier_type_code_38 character varying(100),
    other_provider_identifier_state_38 character varying(100),
    other_provider_identifier_issuer_38 character varying(100),
    other_provider_identifier_39 character varying(100),
    other_provider_identifier_type_code_39 character varying(100),
    other_provider_identifier_state_39 character varying(100),
    other_provider_identifier_issuer_39 character varying(100),
    other_provider_identifier_40 character varying(100),
    other_provider_identifier_type_code_40 character varying(100),
    other_provider_identifier_state_40 character varying(100),
    other_provider_identifier_issuer_40 character varying(100),
    other_provider_identifier_41 character varying(100),
    other_provider_identifier_type_code_41 character varying(100),
    other_provider_identifier_state_41 character varying(100),
    other_provider_identifier_issuer_41 character varying(100),
    other_provider_identifier_42 character varying(100),
    other_provider_identifier_type_code_42 character varying(100),
    other_provider_identifier_state_42 character varying(100),
    other_provider_identifier_issuer_42 character varying(100),
    other_provider_identifier_43 character varying(100),
    other_provider_identifier_type_code_43 character varying(100),
    other_provider_identifier_state_43 character varying(100),
    other_provider_identifier_issuer_43 character varying(100),
    other_provider_identifier_44 character varying(100),
    other_provider_identifier_type_code_44 character varying(100),
    other_provider_identifier_state_44 character varying(100),
    other_provider_identifier_issuer_44 character varying(100),
    other_provider_identifier_45 character varying(100),
    other_provider_identifier_type_code_45 character varying(100),
    other_provider_identifier_state_45 character varying(100),
    other_provider_identifier_issuer_45 character varying(100),
    other_provider_identifier_46 character varying(100),
    other_provider_identifier_type_code_46 character varying(100),
    other_provider_identifier_state_46 character varying(100),
    other_provider_identifier_issuer_46 character varying(100),
    other_provider_identifier_47 character varying(100),
    other_provider_identifier_type_code_47 character varying(100),
    other_provider_identifier_state_47 character varying(100),
    other_provider_identifier_issuer_47 character varying(100),
    other_provider_identifier_48 character varying(100),
    other_provider_identifier_type_code_48 character varying(100),
    other_provider_identifier_state_48 character varying(100),
    other_provider_identifier_issuer_48 character varying(100),
    other_provider_identifier_49 character varying(100),
    other_provider_identifier_type_code_49 character varying(100),
    other_provider_identifier_state_49 character varying(100),
    other_provider_identifier_issuer_49 character varying(100),
    other_provider_identifier_50 character varying(100),
    other_provider_identifier_type_code_50 character varying(100),
    other_provider_identifier_state_50 character varying(100),
    other_provider_identifier_issuer_50 character varying(100),
    is_sole_proprietor character varying(100),
    is_organization_subpart character varying(100),
    parent_organization_lbn character varying(100),
    parent_organization_tin character varying(100),
    authorized_official_name_prefix_text character varying(100),
    authorized_official_name_suffix_text character varying(100),
    authorized_official_credential_text character varying(100),
    healthcare_provider_taxonomy_group_1 character varying(100),
    healthcare_provider_taxonomy_group_2 character varying(100),
    healthcare_provider_taxonomy_group_3 character varying(100),
    healthcare_provider_taxonomy_group_4 character varying(100),
    healthcare_provider_taxonomy_group_5 character varying(100),
    healthcare_provider_taxonomy_group_6 character varying(100),
    healthcare_provider_taxonomy_group_7 character varying(100),
    healthcare_provider_taxonomy_group_8 character varying(100),
    healthcare_provider_taxonomy_group_9 character varying(100),
    healthcare_provider_taxonomy_group_10 character varying(100),
    healthcare_provider_taxonomy_group_11 character varying(100),
    healthcare_provider_taxonomy_group_12 character varying(100),
    healthcare_provider_taxonomy_group_13 character varying(100),
    healthcare_provider_taxonomy_group_14 character varying(100),
    healthcare_provider_taxonomy_group_15 character varying(100),
    certification_date character varying(100),
    filename character varying,
    created_at timestamp with time zone,
    names_with_index tsvector,
    full_name character varying,
    complete_address character varying(500),
    longitude double precision,
    latitude double precision,
    practice_complete_address character varying(500),
    practice_longitude double precision,
    practice_latitude double precision
);


--
-- Name: npidata_practice_loc; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.npidata_practice_loc (
    npi character varying,
    entity_type_code character varying(100),
    replacement_npi character varying(100),
    employer_identification_number_ein character varying(100),
    provider_organization_name_legal_business_name character varying(100),
    provider_last_name_legal_name character varying(100),
    provider_first_name character varying(100),
    provider_middle_name character varying(100),
    provider_name_prefix_text character varying(100),
    provider_name_suffix_text character varying(100),
    provider_credential_text character varying(100),
    provider_other_organization_name character varying(100),
    provider_other_organization_name_type_code character varying(100),
    provider_other_last_name character varying(100),
    provider_other_first_name character varying(100),
    provider_other_middle_name character varying(100),
    provider_other_name_prefix_text character varying(100),
    provider_other_name_suffix_text character varying(100),
    provider_other_credential_text character varying(100),
    provider_other_last_name_type_code character varying(100),
    provider_first_line_business_mailing_address character varying(100),
    provider_second_line_business_mailing_address character varying(100),
    provider_business_mailing_address_city_name character varying(100),
    provider_business_mailing_address_state_name character varying(100),
    provider_business_mailing_address_postal_code character varying(100),
    provider_business_mailing_address_country_code_if_outside_u_s character varying(100),
    provider_business_mailing_address_telephone_number character varying(100),
    provider_business_mailing_address_fax_number character varying(100),
    provider_first_line_business_practice_location_address character varying(100),
    provider_second_line_business_practice_location_address character varying(100),
    provider_business_practice_location_address_city_name character varying(100),
    provider_business_practice_location_address_state_name character varying(100),
    provider_business_practice_location_address_postal_code character varying(100),
    provider_business_practice_location_address_country_code_if_out character varying(100),
    provider_business_practice_location_address_telephone_number character varying(100),
    provider_business_practice_location_address_fax_number character varying(100),
    provider_enumeration_date character varying(100),
    last_update_date character varying(100),
    npi_deactivation_reason_code character varying(100),
    npi_deactivation_date character varying(100),
    npi_reactivation_date character varying(100),
    provider_gender_code character varying(100),
    authorized_official_last_name character varying(100),
    authorized_official_first_name character varying(100),
    authorized_official_middle_name character varying(100),
    authorized_official_title_or_position character varying(100),
    authorized_official_telephone_number character varying(100),
    healthcare_provider_taxonomy_code_1 character varying(100),
    provider_license_number_1 character varying(100),
    provider_license_number_state_code_1 character varying(100),
    healthcare_provider_primary_taxonomy_switch_1 character varying(100),
    healthcare_provider_taxonomy_code_2 character varying(100),
    provider_license_number_2 character varying(100),
    provider_license_number_state_code_2 character varying(100),
    healthcare_provider_primary_taxonomy_switch_2 character varying(100),
    healthcare_provider_taxonomy_code_3 character varying(100),
    provider_license_number_3 character varying(100),
    provider_license_number_state_code_3 character varying(100),
    healthcare_provider_primary_taxonomy_switch_3 character varying(100),
    healthcare_provider_taxonomy_code_4 character varying(100),
    provider_license_number_4 character varying(100),
    provider_license_number_state_code_4 character varying(100),
    healthcare_provider_primary_taxonomy_switch_4 character varying(100),
    healthcare_provider_taxonomy_code_5 character varying(100),
    provider_license_number_5 character varying(100),
    provider_license_number_state_code_5 character varying(100),
    healthcare_provider_primary_taxonomy_switch_5 character varying(100),
    healthcare_provider_taxonomy_code_6 character varying(100),
    provider_license_number_6 character varying(100),
    provider_license_number_state_code_6 character varying(100),
    healthcare_provider_primary_taxonomy_switch_6 character varying(100),
    healthcare_provider_taxonomy_code_7 character varying(100),
    provider_license_number_7 character varying(100),
    provider_license_number_state_code_7 character varying(100),
    healthcare_provider_primary_taxonomy_switch_7 character varying(100),
    healthcare_provider_taxonomy_code_8 character varying(100),
    provider_license_number_8 character varying(100),
    provider_license_number_state_code_8 character varying(100),
    healthcare_provider_primary_taxonomy_switch_8 character varying(100),
    healthcare_provider_taxonomy_code_9 character varying(100),
    provider_license_number_9 character varying(100),
    provider_license_number_state_code_9 character varying(100),
    healthcare_provider_primary_taxonomy_switch_9 character varying(100),
    healthcare_provider_taxonomy_code_10 character varying(100),
    provider_license_number_10 character varying(100),
    provider_license_number_state_code_10 character varying(100),
    healthcare_provider_primary_taxonomy_switch_10 character varying(100),
    healthcare_provider_taxonomy_code_11 character varying(100),
    provider_license_number_11 character varying(100),
    provider_license_number_state_code_11 character varying(100),
    healthcare_provider_primary_taxonomy_switch_11 character varying(100),
    healthcare_provider_taxonomy_code_12 character varying(100),
    provider_license_number_12 character varying(100),
    provider_license_number_state_code_12 character varying(100),
    healthcare_provider_primary_taxonomy_switch_12 character varying(100),
    healthcare_provider_taxonomy_code_13 character varying(100),
    provider_license_number_13 character varying(100),
    provider_license_number_state_code_13 character varying(100),
    healthcare_provider_primary_taxonomy_switch_13 character varying(100),
    healthcare_provider_taxonomy_code_14 character varying(100),
    provider_license_number_14 character varying(100),
    provider_license_number_state_code_14 character varying(100),
    healthcare_provider_primary_taxonomy_switch_14 character varying(100),
    healthcare_provider_taxonomy_code_15 character varying(100),
    provider_license_number_15 character varying(100),
    provider_license_number_state_code_15 character varying(100),
    healthcare_provider_primary_taxonomy_switch_15 character varying(100),
    other_provider_identifier_1 character varying(100),
    other_provider_identifier_type_code_1 character varying(100),
    other_provider_identifier_state_1 character varying(100),
    other_provider_identifier_issuer_1 character varying(100),
    other_provider_identifier_2 character varying(100),
    other_provider_identifier_type_code_2 character varying(100),
    other_provider_identifier_state_2 character varying(100),
    other_provider_identifier_issuer_2 character varying(100),
    other_provider_identifier_3 character varying(100),
    other_provider_identifier_type_code_3 character varying(100),
    other_provider_identifier_state_3 character varying(100),
    other_provider_identifier_issuer_3 character varying(100),
    other_provider_identifier_4 character varying(100),
    other_provider_identifier_type_code_4 character varying(100),
    other_provider_identifier_state_4 character varying(100),
    other_provider_identifier_issuer_4 character varying(100),
    other_provider_identifier_5 character varying(100),
    other_provider_identifier_type_code_5 character varying(100),
    other_provider_identifier_state_5 character varying(100),
    other_provider_identifier_issuer_5 character varying(100),
    other_provider_identifier_6 character varying(100),
    other_provider_identifier_type_code_6 character varying(100),
    other_provider_identifier_state_6 character varying(100),
    other_provider_identifier_issuer_6 character varying(100),
    other_provider_identifier_7 character varying(100),
    other_provider_identifier_type_code_7 character varying(100),
    other_provider_identifier_state_7 character varying(100),
    other_provider_identifier_issuer_7 character varying(100),
    other_provider_identifier_8 character varying(100),
    other_provider_identifier_type_code_8 character varying(100),
    other_provider_identifier_state_8 character varying(100),
    other_provider_identifier_issuer_8 character varying(100),
    other_provider_identifier_9 character varying(100),
    other_provider_identifier_type_code_9 character varying(100),
    other_provider_identifier_state_9 character varying(100),
    other_provider_identifier_issuer_9 character varying(100),
    other_provider_identifier_10 character varying(100),
    other_provider_identifier_type_code_10 character varying(100),
    other_provider_identifier_state_10 character varying(100),
    other_provider_identifier_issuer_10 character varying(100),
    other_provider_identifier_11 character varying(100),
    other_provider_identifier_type_code_11 character varying(100),
    other_provider_identifier_state_11 character varying(100),
    other_provider_identifier_issuer_11 character varying(100),
    other_provider_identifier_12 character varying(100),
    other_provider_identifier_type_code_12 character varying(100),
    other_provider_identifier_state_12 character varying(100),
    other_provider_identifier_issuer_12 character varying(100),
    other_provider_identifier_13 character varying(100),
    other_provider_identifier_type_code_13 character varying(100),
    other_provider_identifier_state_13 character varying(100),
    other_provider_identifier_issuer_13 character varying(100),
    other_provider_identifier_14 character varying(100),
    other_provider_identifier_type_code_14 character varying(100),
    other_provider_identifier_state_14 character varying(100),
    other_provider_identifier_issuer_14 character varying(100),
    other_provider_identifier_15 character varying(100),
    other_provider_identifier_type_code_15 character varying(100),
    other_provider_identifier_state_15 character varying(100),
    other_provider_identifier_issuer_15 character varying(100),
    other_provider_identifier_16 character varying(100),
    other_provider_identifier_type_code_16 character varying(100),
    other_provider_identifier_state_16 character varying(100),
    other_provider_identifier_issuer_16 character varying(100),
    other_provider_identifier_17 character varying(100),
    other_provider_identifier_type_code_17 character varying(100),
    other_provider_identifier_state_17 character varying(100),
    other_provider_identifier_issuer_17 character varying(100),
    other_provider_identifier_18 character varying(100),
    other_provider_identifier_type_code_18 character varying(100),
    other_provider_identifier_state_18 character varying(100),
    other_provider_identifier_issuer_18 character varying(100),
    other_provider_identifier_19 character varying(100),
    other_provider_identifier_type_code_19 character varying(100),
    other_provider_identifier_state_19 character varying(100),
    other_provider_identifier_issuer_19 character varying(100),
    other_provider_identifier_20 character varying(100),
    other_provider_identifier_type_code_20 character varying(100),
    other_provider_identifier_state_20 character varying(100),
    other_provider_identifier_issuer_20 character varying(100),
    other_provider_identifier_21 character varying(100),
    other_provider_identifier_type_code_21 character varying(100),
    other_provider_identifier_state_21 character varying(100),
    other_provider_identifier_issuer_21 character varying(100),
    other_provider_identifier_22 character varying(100),
    other_provider_identifier_type_code_22 character varying(100),
    other_provider_identifier_state_22 character varying(100),
    other_provider_identifier_issuer_22 character varying(100),
    other_provider_identifier_23 character varying(100),
    other_provider_identifier_type_code_23 character varying(100),
    other_provider_identifier_state_23 character varying(100),
    other_provider_identifier_issuer_23 character varying(100),
    other_provider_identifier_24 character varying(100),
    other_provider_identifier_type_code_24 character varying(100),
    other_provider_identifier_state_24 character varying(100),
    other_provider_identifier_issuer_24 character varying(100),
    other_provider_identifier_25 character varying(100),
    other_provider_identifier_type_code_25 character varying(100),
    other_provider_identifier_state_25 character varying(100),
    other_provider_identifier_issuer_25 character varying(100),
    other_provider_identifier_26 character varying(100),
    other_provider_identifier_type_code_26 character varying(100),
    other_provider_identifier_state_26 character varying(100),
    other_provider_identifier_issuer_26 character varying(100),
    other_provider_identifier_27 character varying(100),
    other_provider_identifier_type_code_27 character varying(100),
    other_provider_identifier_state_27 character varying(100),
    other_provider_identifier_issuer_27 character varying(100),
    other_provider_identifier_28 character varying(100),
    other_provider_identifier_type_code_28 character varying(100),
    other_provider_identifier_state_28 character varying(100),
    other_provider_identifier_issuer_28 character varying(100),
    other_provider_identifier_29 character varying(100),
    other_provider_identifier_type_code_29 character varying(100),
    other_provider_identifier_state_29 character varying(100),
    other_provider_identifier_issuer_29 character varying(100),
    other_provider_identifier_30 character varying(100),
    other_provider_identifier_type_code_30 character varying(100),
    other_provider_identifier_state_30 character varying(100),
    other_provider_identifier_issuer_30 character varying(100),
    other_provider_identifier_31 character varying(100),
    other_provider_identifier_type_code_31 character varying(100),
    other_provider_identifier_state_31 character varying(100),
    other_provider_identifier_issuer_31 character varying(100),
    other_provider_identifier_32 character varying(100),
    other_provider_identifier_type_code_32 character varying(100),
    other_provider_identifier_state_32 character varying(100),
    other_provider_identifier_issuer_32 character varying(100),
    other_provider_identifier_33 character varying(100),
    other_provider_identifier_type_code_33 character varying(100),
    other_provider_identifier_state_33 character varying(100),
    other_provider_identifier_issuer_33 character varying(100),
    other_provider_identifier_34 character varying(100),
    other_provider_identifier_type_code_34 character varying(100),
    other_provider_identifier_state_34 character varying(100),
    other_provider_identifier_issuer_34 character varying(100),
    other_provider_identifier_35 character varying(100),
    other_provider_identifier_type_code_35 character varying(100),
    other_provider_identifier_state_35 character varying(100),
    other_provider_identifier_issuer_35 character varying(100),
    other_provider_identifier_36 character varying(100),
    other_provider_identifier_type_code_36 character varying(100),
    other_provider_identifier_state_36 character varying(100),
    other_provider_identifier_issuer_36 character varying(100),
    other_provider_identifier_37 character varying(100),
    other_provider_identifier_type_code_37 character varying(100),
    other_provider_identifier_state_37 character varying(100),
    other_provider_identifier_issuer_37 character varying(100),
    other_provider_identifier_38 character varying(100),
    other_provider_identifier_type_code_38 character varying(100),
    other_provider_identifier_state_38 character varying(100),
    other_provider_identifier_issuer_38 character varying(100),
    other_provider_identifier_39 character varying(100),
    other_provider_identifier_type_code_39 character varying(100),
    other_provider_identifier_state_39 character varying(100),
    other_provider_identifier_issuer_39 character varying(100),
    other_provider_identifier_40 character varying(100),
    other_provider_identifier_type_code_40 character varying(100),
    other_provider_identifier_state_40 character varying(100),
    other_provider_identifier_issuer_40 character varying(100),
    other_provider_identifier_41 character varying(100),
    other_provider_identifier_type_code_41 character varying(100),
    other_provider_identifier_state_41 character varying(100),
    other_provider_identifier_issuer_41 character varying(100),
    other_provider_identifier_42 character varying(100),
    other_provider_identifier_type_code_42 character varying(100),
    other_provider_identifier_state_42 character varying(100),
    other_provider_identifier_issuer_42 character varying(100),
    other_provider_identifier_43 character varying(100),
    other_provider_identifier_type_code_43 character varying(100),
    other_provider_identifier_state_43 character varying(100),
    other_provider_identifier_issuer_43 character varying(100),
    other_provider_identifier_44 character varying(100),
    other_provider_identifier_type_code_44 character varying(100),
    other_provider_identifier_state_44 character varying(100),
    other_provider_identifier_issuer_44 character varying(100),
    other_provider_identifier_45 character varying(100),
    other_provider_identifier_type_code_45 character varying(100),
    other_provider_identifier_state_45 character varying(100),
    other_provider_identifier_issuer_45 character varying(100),
    other_provider_identifier_46 character varying(100),
    other_provider_identifier_type_code_46 character varying(100),
    other_provider_identifier_state_46 character varying(100),
    other_provider_identifier_issuer_46 character varying(100),
    other_provider_identifier_47 character varying(100),
    other_provider_identifier_type_code_47 character varying(100),
    other_provider_identifier_state_47 character varying(100),
    other_provider_identifier_issuer_47 character varying(100),
    other_provider_identifier_48 character varying(100),
    other_provider_identifier_type_code_48 character varying(100),
    other_provider_identifier_state_48 character varying(100),
    other_provider_identifier_issuer_48 character varying(100),
    other_provider_identifier_49 character varying(100),
    other_provider_identifier_type_code_49 character varying(100),
    other_provider_identifier_state_49 character varying(100),
    other_provider_identifier_issuer_49 character varying(100),
    other_provider_identifier_50 character varying(100),
    other_provider_identifier_type_code_50 character varying(100),
    other_provider_identifier_state_50 character varying(100),
    other_provider_identifier_issuer_50 character varying(100),
    is_sole_proprietor character varying(100),
    is_organization_subpart character varying(100),
    parent_organization_lbn character varying(100),
    parent_organization_tin character varying(100),
    authorized_official_name_prefix_text character varying(100),
    authorized_official_name_suffix_text character varying(100),
    authorized_official_credential_text character varying(100),
    healthcare_provider_taxonomy_group_1 character varying(100),
    healthcare_provider_taxonomy_group_2 character varying(100),
    healthcare_provider_taxonomy_group_3 character varying(100),
    healthcare_provider_taxonomy_group_4 character varying(100),
    healthcare_provider_taxonomy_group_5 character varying(100),
    healthcare_provider_taxonomy_group_6 character varying(100),
    healthcare_provider_taxonomy_group_7 character varying(100),
    healthcare_provider_taxonomy_group_8 character varying(100),
    healthcare_provider_taxonomy_group_9 character varying(100),
    healthcare_provider_taxonomy_group_10 character varying(100),
    healthcare_provider_taxonomy_group_11 character varying(100),
    healthcare_provider_taxonomy_group_12 character varying(100),
    healthcare_provider_taxonomy_group_13 character varying(100),
    healthcare_provider_taxonomy_group_14 character varying(100),
    healthcare_provider_taxonomy_group_15 character varying(100),
    certification_date character varying(100),
    filename character varying,
    created_at character varying,
    names_with_index character varying,
    full_name character varying,
    complete_address character varying,
    longitude character varying,
    latitude character varying,
    practice_complete_address character varying,
    practice_longitude character varying,
    practice_latitude character varying
);


--
-- Name: npidata_transpose; Type: VIEW; Schema: doctors; Owner: -
--

CREATE VIEW doctors.npidata_transpose AS
 SELECT n.npi,
    x.key,
    x.value
   FROM doctors.npidata n,
    LATERAL jsonb_each_text(to_jsonb(n.*)) x(key, value)
  WHERE ((x.key <> 'npi'::text) AND (x.value IS NOT NULL));


--
-- Name: taxonomy_codes; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.taxonomy_codes (
    code character varying(2000),
    "grouping" character varying(2000),
    classification character varying(2000),
    specialization character varying(2000),
    definition character varying(10000),
    notes character varying(10000),
    display_name character varying(2000),
    section character varying(2000)
);


--
-- Name: npidata_transpose_taxonomy_desc; Type: VIEW; Schema: doctors; Owner: -
--

CREATE VIEW doctors.npidata_transpose_taxonomy_desc AS
 SELECT nt.npi,
    nt.key,
    nt.value,
    tc.classification
   FROM (doctors.npidata_transpose nt
     LEFT JOIN doctors.taxonomy_codes tc ON (((nt.value = (tc.code)::text) AND (nt.key ~~ '%taxonomy%'::text))));


--
-- Name: opt_out_providers; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.opt_out_providers (
    first_name character varying(100),
    last_name character varying(100),
    npi integer,
    specialty character varying(100),
    optout_effective_date character varying(100),
    optout_end_date character varying(100),
    first_line_street_address character varying(100),
    second_line_street_address character varying(100),
    city_name character varying(100),
    state_code character varying(100),
    zip_code character varying(100),
    eligible_to_order_and_refer character(1),
    last_updated character varying(100),
    filename character varying(200),
    created_at timestamp with time zone
);


--
-- Name: procedures; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.procedures (
    rndrng_npi integer,
    rndrng_prvdr_last_org_name character varying(100),
    rndrng_prvdr_first_name character varying(100),
    rndrng_prvdr_mi character varying(100),
    rndrng_prvdr_crdntls character varying(100),
    rndrng_prvdr_gndr character(1),
    rndrng_prvdr_ent_cd character(1),
    rndrng_prvdr_st1 character varying(200),
    rndrng_prvdr_st2 character varying(200),
    rndrng_prvdr_city character varying(100),
    rndrng_prvdr_state_abrvtn character varying(100),
    rndrng_prvdr_state_fips character varying(100),
    rndrng_prvdr_zip5 character varying(100),
    rndrng_prvdr_ruca character varying(100),
    rndrng_prvdr_ruca_desc character varying(100),
    rndrng_prvdr_cntry character varying(100),
    rndrng_prvdr_type character varying(100),
    rndrng_prvdr_mdcr_prtcptg_ind character(1),
    hcpcs_cd character varying(100),
    hcpcs_desc character varying(500),
    hcpcs_drug_ind character(1),
    place_of_srvc character(1),
    tot_benes real,
    tot_srvcs real,
    tot_bene_day_srvcs real,
    avg_sbmtd_chrg real,
    avg_mdcr_alowd_amt real,
    avg_mdcr_pymt_amt real,
    avg_mdcr_stdzd_amt real,
    filename character varying(200),
    created_at timestamp with time zone
);


--
-- Name: research_payments; Type: TABLE; Schema: doctors; Owner: -
--

CREATE TABLE doctors.research_payments (
    change_type character varying(20),
    covered_recipient_type character varying(50),
    noncovered_recipient_entity_name character varying(50),
    teaching_hospital_ccn character varying(6),
    teaching_hospital_id integer,
    teaching_hospital_name character varying(100),
    covered_recipient_profile_id integer,
    covered_recipient_npi integer,
    covered_recipient_first_name character varying(20),
    covered_recipient_middle_name character varying(20),
    covered_recipient_last_name character varying(35),
    covered_recipient_name_suffix character varying(5),
    recipient_primary_business_street_address_line1 character varying(55),
    recipient_primary_business_street_address_line2 character varying(55),
    recipient_city character varying(40),
    recipient_state character(2),
    recipient_zip_code character varying(10),
    recipient_country character varying(100),
    recipient_province character varying(20),
    recipient_postal_code character varying(20),
    covered_recipient_primary_type_1 character varying(100),
    covered_recipient_primary_type_2 character varying(100),
    covered_recipient_primary_type_3 character varying(100),
    covered_recipient_primary_type_4 character varying(100),
    covered_recipient_primary_type_5 character varying(100),
    covered_recipient_primary_type_6 character varying(100),
    covered_recipient_specialty_1 character varying(300),
    covered_recipient_specialty_2 character varying(300),
    covered_recipient_specialty_3 character varying(300),
    covered_recipient_specialty_4 character varying(300),
    covered_recipient_specialty_5 character varying(300),
    covered_recipient_specialty_6 character varying(300),
    covered_recipient_license_state_code1 character(2),
    covered_recipient_license_state_code2 character(2),
    covered_recipient_license_state_code3 character(2),
    covered_recipient_license_state_code4 character(2),
    covered_recipient_license_state_code5 character(2),
    principal_investigator_1_covered_recipient_type character varying(200),
    principal_investigator_1_profile_id integer,
    principal_investigator_1_npi integer,
    principal_investigator_1_first_name character varying(20),
    principal_investigator_1_middle_name character varying(20),
    principal_investigator_1_last_name character varying(35),
    principal_investigator_1_name_suffix_ character varying(5),
    principal_investigator_1_business_street_address_line1 character varying(55),
    principal_investigator_1_business_street_address_line2 character varying(55),
    principal_investigator_1_city character varying(40),
    principal_investigator_1_state character(2),
    principal_investigator_1_zip_code character varying(10),
    principal_investigator_1_country character varying(100),
    principal_investigator_1_province character varying(20),
    principal_investigator_1_postal_code character varying(20),
    principal_investigator_1_primary_type_1 character varying(50),
    principal_investigator_1_primary_type_2 character varying(50),
    principal_investigator_1_primary_type_3 character varying(50),
    principal_investigator_1_primary_type_4 character varying(50),
    principal_investigator_1_primary_type_5 character varying(50),
    principal_investigator_1_primary_type_6 character varying(50),
    principal_investigator_1_specialty_1 character varying(300),
    principal_investigator_1_specialty_2 character varying(300),
    principal_investigator_1_specialty_3 character varying(300),
    principal_investigator_1_specialty_4 character varying(300),
    principal_investigator_1_specialty_5 character varying(300),
    principal_investigator_1_specialty_6 character varying(300),
    principal_investigator_1_license_state_code1 character(2),
    principal_investigator_1_license_state_code2 character(2),
    principal_investigator_1_license_state_code3 character(2),
    principal_investigator_1_license_state_code4 character(2),
    principal_investigator_1_license_state_code5 character(2),
    principal_investigator_2_covered_recipient_type character varying(200),
    principal_investigator_2_profile_id integer,
    principal_investigator_2_npi integer,
    principal_investigator_2_first_name character varying(20),
    principal_investigator_2_middle_name character varying(20),
    principal_investigator_2_last_name character varying(35),
    principal_investigator_2_name_suffix character varying(5),
    principal_investigator_2_business_street_address_line1 character varying(55),
    principal_investigator_2_business_street_address_line2 character varying(55),
    principal_investigator_2_city character varying(40),
    principal_investigator_2_state character(2),
    principal_investigator_2_zip_code character varying(10),
    principal_investigator_2_country character varying(100),
    principal_investigator_2_province character varying(20),
    principal_investigator_2_postal_code character varying(20),
    principal_investigator_2_primary_type_1 character varying(50),
    principal_investigator_2_primary_type_2 character varying(50),
    principal_investigator_2_primary_type_3 character varying(50),
    principal_investigator_2_primary_type_4 character varying(50),
    principal_investigator_2_primary_type_5 character varying(50),
    principal_investigator_2_primary_type_6 character varying(50),
    principal_investigator_2_specialty_1 character varying(300),
    principal_investigator_2_specialty_2 character varying(300),
    principal_investigator_2_specialty_3 character varying(300),
    principal_investigator_2_specialty_4 character varying(300),
    principal_investigator_2_specialty_5 character varying(300),
    principal_investigator_2_specialty_6 character varying(300),
    principal_investigator_2_license_state_code1 character(2),
    principal_investigator_2_license_state_code2 character(2),
    principal_investigator_2_license_state_code3 character(2),
    principal_investigator_2_license_state_code4 character(2),
    principal_investigator_2_license_state_code5 character(2),
    principal_investigator_3_covered_recipient_type character varying(200),
    principal_investigator_3_profile_id integer,
    principal_investigator_3_npi integer,
    principal_investigator_3_first_name character varying(20),
    principal_investigator_3_middle_name character varying(20),
    principal_investigator_3_last_name character varying(35),
    principal_investigator_3_name_suffix character varying(5),
    principal_investigator_3_business_street_address_line1 character varying(55),
    principal_investigator_3_business_street_address_line2 character varying(55),
    principal_investigator_3_city character varying(40),
    principal_investigator_3_state character(2),
    principal_investigator_3_zip_code character varying(10),
    principal_investigator_3_country character varying(100),
    principal_investigator_3_province character varying(20),
    principal_investigator_3_postal_code character varying(20),
    principal_investigator_3_primary_type_1 character varying(50),
    principal_investigator_3_primary_type_2 character varying(50),
    principal_investigator_3_primary_type_3 character varying(50),
    principal_investigator_3_primary_type_4 character varying(50),
    principal_investigator_3_primary_type_5 character varying(50),
    principal_investigator_3_primary_type_6 character varying(50),
    principal_investigator_3_specialty_1 character varying(300),
    principal_investigator_3_specialty_2 character varying(300),
    principal_investigator_3_specialty_3 character varying(300),
    principal_investigator_3_specialty_4 character varying(300),
    principal_investigator_3_specialty_5 character varying(300),
    principal_investigator_3_specialty_6 character varying(300),
    principal_investigator_3_license_state_code1 character(2),
    principal_investigator_3_license_state_code2 character(2),
    principal_investigator_3_license_state_code3 character(2),
    principal_investigator_3_license_state_code4 character(2),
    principal_investigator_3_license_state_code5 character(2),
    principal_investigator_4_covered_recipient_type character varying(200),
    principal_investigator_4_profile_id integer,
    principal_investigator_4_npi integer,
    principal_investigator_4_first_name character varying(20),
    principal_investigator_4_middle_name character varying(20),
    principal_investigator_4_last_name character varying(35),
    principal_investigator_4_name_suffix character varying(5),
    principal_investigator_4_business_street_address_line1 character varying(55),
    principal_investigator_4_business_street_address_line2 character varying(55),
    principal_investigator_4_city character varying(40),
    principal_investigator_4_state character(2),
    principal_investigator_4_zip_code character varying(10),
    principal_investigator_4_country character varying(100),
    principal_investigator_4_province character varying(20),
    principal_investigator_4_postal_code character varying(20),
    principal_investigator_4_primary_type_1 character varying(50),
    principal_investigator_4_primary_type_2 character varying(50),
    principal_investigator_4_primary_type_3 character varying(50),
    principal_investigator_4_primary_type_4 character varying(50),
    principal_investigator_4_primary_type_5 character varying(50),
    principal_investigator_4_primary_type_6 character varying(50),
    principal_investigator_4_specialty_1 character varying(300),
    principal_investigator_4_specialty_2 character varying(300),
    principal_investigator_4_specialty_3 character varying(300),
    principal_investigator_4_specialty_4 character varying(300),
    principal_investigator_4_specialty_5 character varying(300),
    principal_investigator_4_specialty_6 character varying(300),
    principal_investigator_4_license_state_code1 character(2),
    principal_investigator_4_license_state_code2 character(2),
    principal_investigator_4_license_state_code3 character(2),
    principal_investigator_4_license_state_code4 character(2),
    principal_investigator_4_license_state_code5 character(2),
    principal_investigator_5_covered_recipient_type character varying(200),
    principal_investigator_5_profile_id integer,
    principal_investigator_5_npi integer,
    principal_investigator_5_first_name character varying(20),
    principal_investigator_5_middle_name character varying(20),
    principal_investigator_5_last_name character varying(35),
    principal_investigator_5_name_suffix character varying(5),
    principal_investigator_5_business_street_address_line1 character varying(55),
    principal_investigator_5_business_street_address_line2 character varying(55),
    principal_investigator_5_city character varying(40),
    principal_investigator_5_state character(2),
    principal_investigator_5_zip_code character varying(10),
    principal_investigator_5_country character varying(100),
    principal_investigator_5_province character varying(20),
    principal_investigator_5_postal_code character varying(20),
    principal_investigator_5_primary_type_1 character varying(50),
    principal_investigator_5_primary_type_2 character varying(50),
    principal_investigator_5_primary_type_3 character varying(50),
    principal_investigator_5_primary_type_4 character varying(50),
    principal_investigator_5_primary_type_5 character varying(50),
    principal_investigator_5_primary_type_6 character varying(50),
    principal_investigator_5_specialty_1 character varying(300),
    principal_investigator_5_specialty_2 character varying(300),
    principal_investigator_5_specialty_3 character varying(300),
    principal_investigator_5_specialty_4 character varying(300),
    principal_investigator_5_specialty_5 character varying(300),
    principal_investigator_5_specialty_6 character varying(300),
    principal_investigator_5_license_state_code1 character(2),
    principal_investigator_5_license_state_code2 character(2),
    principal_investigator_5_license_state_code3 character(2),
    principal_investigator_5_license_state_code4 character(2),
    principal_investigator_5_license_state_code5 character(2),
    submitting_applicable_manufacturer_or_applicable_gpo_name character varying(100),
    applicable_manufacturer_or_applicable_gpo_making_payment_id character varying(12),
    applicable_manufacturer_or_applicable_gpo_making_payment_name character varying(100),
    applicable_manufacturer_or_applicable_gpo_making_payment_state character(2),
    applicable_manufacturer_or_applicable_gpo_making_payment_countr character varying(100),
    related_product_indicator character varying(100),
    covered_or_noncovered_indicator_1 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_1 character varying(100),
    product_category_or_therapeutic_area_1 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_1 character varying(500),
    associated_drug_or_biological_ndc_1 character varying(100),
    associated_device_or_medical_supply_pdi_1 character varying(100),
    covered_or_noncovered_indicator_2 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_ character varying(100),
    product_category_or_therapeutic_area_2 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_2 character varying(500),
    associated_drug_or_biological_ndc_2 character varying(100),
    associated_device_or_medical_supply_pdi_2 character varying(100),
    covered_or_noncovered_indicator_3 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_3 character varying(100),
    product_category_or_therapeutic_area_3 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_3 character varying(500),
    associated_drug_or_biological_ndc_3 character varying(100),
    associated_device_or_medical_supply_pdi_3 character varying(100),
    covered_or_noncovered_indicator_4 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_4 character varying(100),
    product_category_or_therapeutic_area_4 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_4 character varying(500),
    associated_drug_or_biological_ndc_4 character varying(100),
    associated_device_or_medical_supply_pdi_4 character varying(100),
    covered_or_noncovered_indicator_5 character varying(100),
    indicate_drug_or_biological_or_device_or_medical_supply_5 character varying(100),
    product_category_or_therapeutic_area_5 character varying(100),
    name_of_drug_or_biological_or_device_or_medical_supply_5 character varying(500),
    associated_drug_or_biological_ndc_5 character varying(100),
    associated_device_or_medical_supply_pdi_5 character varying(100),
    total_amount_of_payment_usdollars double precision,
    date_of_payment date,
    form_of_payment_or_transfer_of_value character varying(100),
    expenditure_category1 character varying(50),
    expenditure_category2 character varying(50),
    expenditure_category3 character varying(50),
    expenditure_category4 character varying(50),
    expenditure_category5 character varying(50),
    expenditure_category6 character varying(50),
    preclinical_research_indicator character(3),
    delay_in_publication_indicator character(3),
    name_of_study character varying(500),
    dispute_status_for_publication character(3),
    record_id integer,
    program_year character(4),
    payment_publication_date date,
    clinicaltrials_gov_identifier character varying(11),
    research_information_link character varying(2083),
    context_of_research character varying(500)
);


--
-- Name: endorsements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.endorsements (
    id integer NOT NULL,
    "endorserNPI" bigint,
    "endorseeNPI" bigint,
    areas character varying(255),
    message text DEFAULT ''::text,
    anonymous boolean,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "isEndorsement" boolean,
    "isReported" integer,
    "userId" uuid
);


--
-- Name: endorsements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.endorsements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: endorsements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.endorsements_id_seq OWNED BY public.endorsements.id;


--
-- Name: hi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hi (
    name character varying
);


--
-- Name: logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logs (
    id uuid NOT NULL,
    title character varying(255),
    description character varying(255),
    date timestamp with time zone DEFAULT '2024-01-31 13:51:31.995+00'::timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: manualverifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manualverifications (
    id uuid NOT NULL,
    status boolean DEFAULT false,
    user_id uuid,
    profile json,
    img_url character varying(255),
    user_name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id uuid NOT NULL,
    rating integer,
    message text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" uuid,
    "providerNPI" bigint,
    "ratingFields" json,
    "isReported" integer
);


--
-- Name: superadmin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.superadmin (
    id uuid NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    email character varying(255),
    password character varying(255),
    others json,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    type character varying(255),
    "firstName" character varying(255),
    "lastName" character varying(255),
    is_active boolean,
    npi bigint,
    "lastLoggedIn" timestamp with time zone,
    "IPAddress" character varying(255),
    email character varying(255),
    password character varying(255),
    others json,
    verified boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: verifyotp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.verifyotp (
    id uuid NOT NULL,
    token bigint,
    email character varying(255),
    date character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: endorsements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.endorsements ALTER COLUMN id SET DEFAULT nextval('public.endorsements_id_seq'::regclass);


--
-- Name: endorsements endorsements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.endorsements
    ADD CONSTRAINT endorsements_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: manualverifications manualverifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manualverifications
    ADD CONSTRAINT manualverifications_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: superadmin superadmin_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.superadmin
    ADD CONSTRAINT superadmin_email_key UNIQUE (email);


--
-- Name: superadmin superadmin_email_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.superadmin
    ADD CONSTRAINT superadmin_email_key1 UNIQUE (email);


--
-- Name: superadmin superadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.superadmin
    ADD CONSTRAINT superadmin_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: verifyotp verifyotp_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verifyotp
    ADD CONSTRAINT verifyotp_pkey PRIMARY KEY (id);


--
-- Name: clinicians_adrs_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX clinicians_adrs_idx ON doctors.clinicians_medicare USING btree (adrs_id);


--
-- Name: full_name_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX full_name_idx ON doctors.clinicians_medicare USING gin (full_name);


--
-- Name: full_name_idxx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX full_name_idxx ON doctors.medicare_facility_affiliations USING gin (full_name);


--
-- Name: gnrl_payments_npi; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX gnrl_payments_npi ON doctors.general_payments USING btree (covered_recipient_npi);


--
-- Name: medicare_facility_affiliations_certification_number_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX medicare_facility_affiliations_certification_number_index ON doctors.medicare_facility_affiliations USING btree ("Facility_Affiliations_Certification_Number");


--
-- Name: medications_npi_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX medications_npi_idx ON doctors.medications USING btree (prscrbr_npi);


--
-- Name: names_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX names_index ON doctors.npidata USING gin (names_with_index);


--
-- Name: npi; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npi ON doctors.npidata USING btree (npi);


--
-- Name: npi_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npi_index ON doctors.npidata USING btree (npi);


--
-- Name: npi_index1; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npi_index1 ON doctors.clinicians_medicare USING btree (npi);


--
-- Name: npi_index_1; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npi_index_1 ON doctors.medicare_facility_affiliations USING btree ("NPI");


--
-- Name: npidata_complete_lat_long_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npidata_complete_lat_long_index ON doctors.npidata_complete_lat_long USING btree (npi);


--
-- Name: npidata_firstname_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npidata_firstname_idx ON doctors.npidata USING btree (provider_first_name);


--
-- Name: npidata_npi_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npidata_npi_idx ON doctors.npidata USING btree (npi);


--
-- Name: npidata_practice_loc_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npidata_practice_loc_index ON doctors.npidata_practice_loc USING btree (npi);


--
-- Name: npidata_provider_organization_name_legal_business_name_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX npidata_provider_organization_name_legal_business_name_idx ON doctors.npidata USING btree (provider_organization_name_legal_business_name);


--
-- Name: opt_out_providers_npi_idx; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX opt_out_providers_npi_idx ON doctors.opt_out_providers USING btree (npi);


--
-- Name: org_name_ind; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX org_name_ind ON doctors.npidata USING gin (org_name_search);


--
-- Name: org_pac_id_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX org_pac_id_index ON doctors.clinicians_medicare USING btree (org_pac_id);


--
-- Name: payments_npi; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX payments_npi ON doctors.research_payments USING btree (principal_investigator_1_npi);


--
-- Name: postal_code; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX postal_code ON doctors.npidata USING gin (provider_business_mailing_address_postal_code);


--
-- Name: postal_code_taxonomy; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX postal_code_taxonomy ON doctors.npidata USING gin (provider_business_mailing_address_postal_code, healthcare_provider_taxonomy_code_1);


--
-- Name: practice_zip; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX practice_zip ON doctors.npidata USING btree (practice_zip_short);


--
-- Name: provider_business_name; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX provider_business_name ON doctors.npidata USING btree (provider_organization_name_legal_business_name);


--
-- Name: provider_city; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX provider_city ON doctors.npidata USING btree (provider_business_mailing_address_city_name);


--
-- Name: provider_city_practice; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX provider_city_practice ON doctors.npidata USING btree (provider_business_practice_location_address_city_name);


--
-- Name: provider_type_and_city; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX provider_type_and_city ON doctors.npidata USING btree (provider_organization_name_legal_business_name, provider_business_mailing_address_city_name);


--
-- Name: provider_type_and_city_practice; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX provider_type_and_city_practice ON doctors.npidata USING btree (provider_organization_name_legal_business_name, provider_business_practice_location_address_city_name);


--
-- Name: research_payments_ccn; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX research_payments_ccn ON doctors.general_payments USING btree (teaching_hospital_ccn);


--
-- Name: research_payments_npi; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX research_payments_npi ON doctors.general_payments USING btree (covered_recipient_npi);


--
-- Name: spatial_location; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX spatial_location ON doctors.npidata USING gist (mailing_location_point);

ALTER TABLE doctors.npidata CLUSTER ON spatial_location;


--
-- Name: speciality_state_city; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX speciality_state_city ON doctors.npidata USING btree (COALESCE(healthcare_provider_taxonomy_code_1, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_2, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_3, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_4, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_5, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_6, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_7, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_8, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_9, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_10, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_11, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_12, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_13, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_14, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_15, ''::character varying), provider_business_mailing_address_city_name, provider_business_mailing_address_state_name);


--
-- Name: speciality_state_city_practice; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX speciality_state_city_practice ON doctors.npidata USING btree (COALESCE(healthcare_provider_taxonomy_code_1, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_2, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_3, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_4, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_5, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_6, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_7, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_8, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_9, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_10, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_11, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_12, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_13, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_14, ''::character varying), COALESCE(healthcare_provider_taxonomy_code_15, ''::character varying), provider_business_practice_location_address_city_name, provider_business_practice_location_address_state_name);


--
-- Name: state_city; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX state_city ON doctors.npidata USING gin (provider_business_mailing_address_city_name, provider_business_mailing_address_state_name);


--
-- Name: state_city_practice; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX state_city_practice ON doctors.npidata USING gin (provider_business_practice_location_address_city_name, provider_business_practice_location_address_state_name);


--
-- Name: states_city; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX states_city ON doctors.npidata USING btree (provider_business_mailing_address_city_name, provider_business_mailing_address_state_name);


--
-- Name: states_city_practice; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX states_city_practice ON doctors.npidata USING btree (provider_business_practice_location_address_city_name, provider_business_practice_location_address_state_name);


--
-- Name: taxonomy_1; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_1 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_1);


--
-- Name: taxonomy_10; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_10 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_10);


--
-- Name: taxonomy_11; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_11 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_11);


--
-- Name: taxonomy_12; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_12 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_12);


--
-- Name: taxonomy_13; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_13 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_13);


--
-- Name: taxonomy_14; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_14 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_14);


--
-- Name: taxonomy_15; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_15 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_15);


--
-- Name: taxonomy_2; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_2 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_2);


--
-- Name: taxonomy_3; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_3 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_3);


--
-- Name: taxonomy_4; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_4 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_4);


--
-- Name: taxonomy_5; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_5 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_5);


--
-- Name: taxonomy_6; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_6 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_6);


--
-- Name: taxonomy_7; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_7 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_7);


--
-- Name: taxonomy_8; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_8 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_8);


--
-- Name: taxonomy_9; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX taxonomy_9 ON doctors.npidata USING btree (healthcare_provider_taxonomy_code_9);


--
-- Name: zip_index; Type: INDEX; Schema: doctors; Owner: -
--

CREATE INDEX zip_index ON doctors.npidata USING btree (provider_business_practice_location_address_postal_code);


--
-- Name: reviews reviews_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "reviews_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA doctors; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA doctors TO postgres_read;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_advance(text, pg_lsn); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_advance(text, pg_lsn) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_create(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_create(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_drop(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_drop(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_oid(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_oid(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_progress(text, boolean); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_progress(text, boolean) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_is_setup(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_is_setup() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_progress(boolean); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_progress(boolean) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_reset(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_reset() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_setup(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_setup(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_xact_reset(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_reset() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn) TO cloudsqlsuperuser;


--
-- Name: TABLE clinicians_medicare; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.clinicians_medicare TO postgres_read;


--
-- Name: TABLE hospitals; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.hospitals TO postgres_read;


--
-- Name: TABLE medicare_facility_affiliations; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.medicare_facility_affiliations TO postgres_read;


--
-- Name: TABLE clinicians_medicare_hospitals; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.clinicians_medicare_hospitals TO postgres_read;


--
-- Name: TABLE conditions_procedure2; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.conditions_procedure2 TO postgres_read;


--
-- Name: TABLE db_conditions; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.db_conditions TO postgres_read;


--
-- Name: TABLE db_procedures; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.db_procedures TO postgres_read;


--
-- Name: TABLE general_payments; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.general_payments TO postgres_read;


--
-- Name: TABLE malpractice; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.malpractice TO postgres_read;


--
-- Name: TABLE medications; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.medications TO postgres_read;


--
-- Name: TABLE npidata; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.npidata TO postgres_read;


--
-- Name: TABLE npidata_complete_lat_long; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.npidata_complete_lat_long TO postgres_read;


--
-- Name: TABLE npidata_practice_loc; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.npidata_practice_loc TO postgres_read;


--
-- Name: TABLE npidata_transpose; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.npidata_transpose TO postgres_read;


--
-- Name: TABLE taxonomy_codes; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.taxonomy_codes TO postgres_read;


--
-- Name: TABLE npidata_transpose_taxonomy_desc; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.npidata_transpose_taxonomy_desc TO postgres_read;


--
-- Name: TABLE opt_out_providers; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.opt_out_providers TO postgres_read;


--
-- Name: TABLE procedures; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.procedures TO postgres_read;


--
-- Name: TABLE research_payments; Type: ACL; Schema: doctors; Owner: -
--

GRANT SELECT ON TABLE doctors.research_payments TO postgres_read;


--
-- PostgreSQL database dump complete
--

