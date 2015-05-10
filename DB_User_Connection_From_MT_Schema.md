# Introduction #

Item "V0005683" from The Defense Information Services (DISA) Oracle Database Security Readiness Review (SRS) requires the Database Schema account to be disabled from login during normal operations.  Since the Mid-Tier Schema connects directly to the Database Schema, multi-tiered deployment of DTGen generated applications are not possible, except for the knowledgeable DBA.

# Why the MT Schema to DB Schema connection Requirement #

The Mid-Tier Schema performs application logic on behalf of the Database Schema.  One of the key reasons to run a multi-tiered architecture is to off-load this processing from the database server.  Since the Mid-Tier Schema is performing work against the Database Schema at a more "raw" level, the Mid-Tier connection requires permission access that would normally be encapsulated in the generated application.  The security for this more "raw" access to the Database Schema is typically handled by a tightly controlled and dedicated network between the mid-tier servers and the database servers.  With such tight network controls, the remote login of such privileged access to the database does not pose a major security risk.