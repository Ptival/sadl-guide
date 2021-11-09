################
SADL Users Guide
################

********************
CLASS_A is a CLASS_B
********************

OWL::

    <CLASS_B rdf:ID="CLASS_A"/>

**What does SADL check?**

SADL will check that the instance `CLASS_A` follows the rules for the class
`CLASS_A`.

****************************
CLASS_A is a type of CLASS_B
****************************

OWL::

    <owl:Class rdf:ID="CLASS_A">
        <rdfs:subClassOf rdf:resource="CLASS_B"/>
    </owl:Class>

**What does SADL check?**

SADL will check that instances of the class `CLASS_A` follows both its own
rules, and the rules of the superclass `CLASS_B`.

********************************************************
property_A describes CLASS_A with values of type CLASS_B
********************************************************

OWL::

    <owl:ObjectProperty rdf:ID="property_A">
        <rdfs:domain rdf:resource="#CLASS_A"/>
        <rdfs:range rdf:resource="#CLASS_B"/>
    </owl:ObjectProperty>

**What does SADL check?**

SADL checks that instances of `CLASS_A` with properties `property_A` have a
value that is a subtype of `CLASS_B`.

*****************************************************
property_A of CLASS_A only has values of type CLASS_B
*****************************************************

The following is generated regardless of whether `property_A` is already known
to describe values of type `CLASS_A`, values of some supertype of `CLASS_A`, or
some entirely unrelated class.

However, if `property_A` was defined with domain `CLASS_C`, and `CLASS_A` has no
subtype relationship with `CLASS_C`, then at use sites, SADL will complain that
`CLASS_A` is not in the domain of `property_A`.

Likewise, this is generated regardless of the relationship between `CLASS_B` and
any other previously-known range of any property `property_A`.

OWL::

    <owl:Class rdf:ID="CLASS_A">
        ...
        <rdfs:subClassOf>
            <owl:Restriction>
                <owl:allValuesFrom>
                    <owl:Class rdf:ID="CLASS_B"/>
                </owl:allValuesFrom>
                <owl:onProperty>
                    <owl:ObjectProperty rdf:ID="property_A"/>
                </owl:onProperty>
            </owl:Restriction>
        </rdfs:subClassOf>
    </owl:Class>

NOTE: if `property_A` is not known to SADL prior to this declaration, then
`rdf:ID="property_A"` is replaced with `rdf:resource="#property_A"`.

**What does SADL check?**

Nothing.

**********************************
property_A is a type of property_B
**********************************

The following is produced regardless of whether the domains and ranges of
`property_A` and `property_B` are compatible in any way.  At use site, SADL will
respect the range of the original declaration of `property_A`.

OWL::

    <owl:ObjectProperty rdf:about="#property_A">
        ...
        <rdfs:subPropertyOf rdf:resource="#property_B"/>
    </owl:ObjectProperty>

**What does SADL check?**

Nothing.

************************************************
propertyA describes CLASS_A with at most 1 value
************************************************

OWL::

    <owl:Class rdf:ID="CLASS_A">
        ...
        <rdfs:subClassOf>
            <owl:Restriction>
                <owl:maxCardinality rdf:datatype="http://www.w3.org/2001/XMLSchema#int">
                    1
                </owl:maxCardinality>
                <owl:onProperty>
                    <owl:DatatypeProperty rdf:ID="propertyA"/>
                </owl:onProperty>
            </owl:Restriction>
        </rdfs:subClassOf>
    </owl:Class>

**What does SADL check?**

Nothing.
